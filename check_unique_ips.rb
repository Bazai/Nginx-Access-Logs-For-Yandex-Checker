# encoding: utf-8
require 'whois'

time_start = Time.now

filename = 'unique_ips.txt'
# filename = 'access_log_test.log'
# filename = 'seo_pages.log'
target_file = 'yandex_ips.txt'
unchecked_file = 'unchecked_ips.txt'
result_arr = []

file_from = File.new(filename, 'r')
file_to = File.new(target_file, 'w')
file_unchecked = File.new(unchecked_file, 'w')

total_ips = file_from.count

i = 0
puts total_ips
puts total_ips
puts file_from.inspect

# Это чисто хак, чтобы потоки не закрывались
file_from.close
file_to.close
file_unchecked.close

target_file = 'yandex_ips.txt'
unchecked_file = 'unchecked_ips.txt'
result_arr = []

file_from = File.new(filename, 'r')
file_to = File.new(target_file, 'w')
file_unchecked = File.new(unchecked_file, 'w')
# Конец хака

file_from.each do |row|
	i += 1
	# if ((row =~ /\/article\// || row =~ /\/article\s/ || row =~ /GET\s\/\sHTTP\/1\.1\// || row =~ /\/country/) && row =~ /178\.154\.161\.29/)
	# if (row =~ /178\.154\.161\.29/)
	ip = row.scan(/(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})/)[0].to_s.strip.sub('["', '').sub('"]', '')
	puts "#{i} из #{total_ips}: " + ip.to_s
	begin
		r = Whois.whois(ip)
		if r.match?(/yandex/)
			unless result_arr.include?(ip)
				result_arr << ip
				file_to.puts(ip)
			end
		end
	rescue Exception => e
		file_unchecked.puts(ip)
	end
end

puts "Обработка закончена. Обработка заняла #{Time.now - time_start} секунд."