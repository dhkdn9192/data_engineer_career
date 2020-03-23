#################################################################
# filter_mail_log.rb
# 메일 로그를 필터링 및 파싱하기 위한 logstash filter 플러그인 코드
#
# by dhkim (2019.05.07)
#################################################################

# register accepts the hashmap passed to "script_params"
# it runs once at startup
def register(params)
  @source_field = params["source_field"]
end


# filter runs for every event
# return the list of events to be passed forward
# returning empty list is equivalent to event.cancel
def filter(event)

  input_log = event.get(@source_field)

  # tag if field isn't present
  if input_log.nil?
    event.set("VALID", '0')
    event.tag("source_field_is_nil")
    return [event]
  end

  if input_log.empty?
    event.set("VALID", '0')
    event.tag("source_field_is_empty")
    return [event]
  end

  # parsing
  parsed_log = parse_mail_log(input_log)

  # drop if not valid log
  if parsed_log.nil?
    event.set("VALID", '0')
    event.tag("parsed_unavailable")
    return []
  end

  # mc 필드는 반드시 값이 있어야 함
  if parsed_log["MC"].nil?
    event.set("VALID", '0')
    event.tag("parsed_unavailable")
    return []
  end

  # set event
  parsed_log.keys.each do |key_field|
    # 원래 필드명의 소문자명과 해당 값을 키-밸류로 매핑하여 event에 입력
    event.set("#{key_field.downcase}", parsed_log[key_field])
  end
  event.set("VALID", '1')

  # puts "---- test ----"
  # puts ">> parsed_log :\n#{parsed_log}"

  # return event
  [event]
end


# 메일로그 한 line을 입력받아 파싱하는 함수
# 파싱 결과는 딕셔너리(Hash)로 반환하며 대상 로그 패턴이 아니라면 nil을 반환한다
def parse_mail_log(input_text)

  # # 예외처리
  # if input_text.nil?
  #   # puts ">> input_text is nill -> return nil"
  #   return nil
  # end

  # 입력 로그가 패턴과 일치하는지 여부 검사 (패턴과 일치하지 않으면 nil 반환)
  matched = input_text.match(/\[.*\]\s+-[A-Z]+\s+!\s+/)
  if matched.nil?
    return nil
  end

  # 추출 대상 필드들
  target_fields = %w(LOGTIME LOGLEVEL MC ACT SIP SID SZ SJ FL FN PF RN RS AI EF ER BX)

  # 각 필드값들을 저장할 딕셔너리(Hash) 초기화
  field_dict = {}
  target_fields.each do |each_field|
    field_dict[each_field] = ""
  end
  # puts ">> init field_dict :\n#{field_dict}"

  # LOGTIME, LOGLEVEL 필드 추출
  logtime = matched[0].match(/\[[^ ]+/)[0].sub('[', '')
  loglevel = matched[0].match(/-[A-Z]+/)[0].sub('-', '')
  field_dict['LOGTIME'] = logtime
  field_dict['LOGLEVEL'] = loglevel
  least = input_text.sub(matched[0], '')  # 입력 로그에서 LOGLEVEL 및 ! 기호까지를 제거
  # puts ">> loglevel : #{loglevel}"

  # SJ 필드 추출 (로그 맨 마지막에 등장하는 것을 전제로 추출)
  if least.include? " SJ:"
    idx_sj = least.index(" SJ:")
    field_sj = least.match(/ SJ:.+$/)
    value_sj = field_sj.nil? ? "" : field_sj[0].sub(' SJ:', '')
    least = least[0..idx_sj-1]
    field_dict['SJ'] = value_sj
    # puts ">> SJ: #{value_sj}"
  end

  # 나머지 로그 문자열을 공백 단위로 split
  split_parts = least.split(' ')
  # puts ">> split_parts: \n#{split_parts}"

  # split된 각 문자열들에서 대상 필드값들을 추출하여 딕셔너리에 저장
  split_parts.each do |each_part|

    # '{필드명}:' 패턴으로 시작하는지 검사
    each_matched = each_part.match(/^[A-Z]+:/)

    if each_matched
      field_name = each_matched[0].sub(':', '')         # 필드명
      field_value = each_part.sub(each_matched[0], '')  # 필드값

      # puts "---------"
      # puts ">> #{field_name} => #{field_value}"

      # 대상 필드라면 딕셔너리에 저장
      if target_fields.include? field_name
        field_dict[field_name] = field_value
      end
    end
  end
  # puts ">> field_dict :\n#{field_dict}"

  # 딕셔너리 반환
  field_dict
end


#####################
###### testing ######
#####################

# 테스트용 로그 텍스트
# sample_log = "[00:02:15 13961.140077461673728] -INFO ! MC:spam ACT:delivered SIP:10.0.1.30 RIP:10.0.1.30 SID:1557154935.310384.140077461673728.mail1 MID:ae3eead2fb8451207fbaed412ef8c7ea@qq.com FN:user-block FL:contents RN:spam-userblock  EF:2249974755@qq.com ER:sookim@genematrix.net OR:sookim@genematrix.net HF:2249974755@qq.com DIP:127.0.0.1 SZ:1618 BX:Spam CS:utf-8 MCS:EUC-KR DATE: SJ:��...��������198974�ڤƦ�M ���..��ֺ��8...5...0������b��oʥQ599228568"


# test "when field exists" do
#   parameters { { "source_field" => "field_A" } }
#   in_event { { "field_A" => "hello" } }
#   puts ">> TEST1"
#   expect("the size is computed") {|events| events.first.get("field_A_size") == 5 }
# end

#test "when field doesn't exist" do
#  parameters { { "source_field" => sample_log } }
#  in_event { { "field_B" => "hello" } }
#  puts ">> TEST2"
#  expect("tags as not found") {|events| events.first.get("tags").nil? }
#end

#test "when drop size is set" do
#  parameters do
#    { "source_field" => sample_log }
#  end
#  in_event { { "field_A" => "a kind of medium sized string" } }
#  puts ">> TEST3"
#  expect("drops events of a certain size class") {|events| events.empty? }
#end
