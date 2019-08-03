require 'unicode_utils/downcase'

def read_dict(dict, ipa_hash)
  dict.each_line do |line|
    word,ipa = line.chomp.split("\t")
    norm_word = UnicodeUtils.downcase(word)
    if word.match(/[A-Z]/) && ipa_hash[norm_word]
      then next
    end
    ipa_hash[norm_word] = ipa
  end
end

def read_wordlist(wordlist, wordlist_hash)
  wordlist.each_line do |line|
    word,ipa = line.chomp.split("\t")
    norm_word = UnicodeUtils.downcase(word)
    if word.match(/[A-Z]/) && ipa_hash[norm_word]
      then next
    end
    wordlist_hash[norm_word] = ipa
  end
end

def transcribe_ipa(file,dict_file)
  text = File.read(file)
  dict = File.read(dict_file)

  ipa_hash = {}
  wordlist_hash = {}
  outtxt = ""

  read_dict(dict, ipa_hash)
  if @wordlist
    wordlist = File.read(@wordlist)
    read_wordlist(wordlist, wordlist_hash)
  end

  text.each_line do |line|
    if !line.match(/^# /)
      if line.match(/[#\*]/) || line.match(/^$/)
        outtxt << line
        next
      end
    end
    words = UnicodeUtils.downcase(line).gsub(/[,\.\?\!:;"’“”„«»\(\)？！，。、·…；：¿¡–—،؟\َُِِّْ]/, "").split(" ")
    tr_line = ""
    words.each do |w|
      hit = ipa_hash[w]
      wl_hit = wordlist_hash[w]
      if wl_hit
        tr_line << wl_hit.gsub(/\//, "") + " "
      elsif hit
        if hit.match(", ")
          hit = hit.split(", ")[0]
        end
        tr_line << hit.gsub(/\//, "") + " "
      else
        tr_line << "@" + w + " "
      end
    end
    outtxt << tr_line.gsub(/@#/, "#").gsub(/\s+$/, "") + "\n"
  end
  outtxt
end
