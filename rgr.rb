require 'systemu'
require 'pathname'

############################################################
# gitのリモートのリポジトリを作成して、ローカルのリポジトリと紐づける
############################################################

def systemu_msg sh
  status, stdout, stderr = systemu sh 
  res = { 
    out: stdout,
    error: stderr,
    msg: [ '$Run shell: '+sh, '$Error: '+stderr ].join("\n")+"\n"
  }
end

if ARGV.size != 1
  puts "[Note] 作成するgitリポジトリの名前を指定してください"
  exit
end

if !Pathname.new(".git").directory?
  puts "[Note] gitで管理されていません"
  exit
end

post = 'curl -H "$AUTH_HDR" -X POST \
       -d "{\"name\":\"'+ARGV[0]+'\",\"auto_init\":true}" \
       https://api.github.com/user/repos'
puts systemu_msg(post)[:msg]

remote = "git remote add origin git@github.com:ragiko/#{ARGV[0]}.git"
puts systemu_msg(remote)[:msg]

pull = "git pull origin master"
res = systemu_msg(pull)[:msg] 

status = "git status"
if !systemu_msg(status)[:out][/conflict/m].nil?
  puts "[Note] コンフリクトが起きているためpushしませんでした"
  exit
end

push = "git push origin master"
puts systemu_msg(push)[:msg]

