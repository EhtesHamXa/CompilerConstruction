#Code_by_HamzaEhteshamFarooq_aka_EhtesHamXa
DataType = ['int','char','string','double','bool']
Keywords = ['class','new','while','if','do','switch','default','else','case',
            'break','goto','return','interface','sealed','static','continue',
            'override','virtual','void','main','abstract','try','as','catch','throw','for']
Encap = ['public','private','proteced']
Access = ['this','base']
Seperator = [';','(',')','{','}','[',']']
Boolean = ['true','false']
Token = Array.new
Linea=1 
def num (chk)
    chk=~/[0-9]/
end
def ids (chak)
    chak=~/[QWERTYUIOPASDFGHJKLZXCVBNMqwertyuiopasdfghjklzxcvbnm_]/
end

def id (iden)
iden =~ /[_QWERTYUIOPASDFGHJKLZXCVBNMqwertyuiopasdfghjklzxcvbnm0-9]/
end
def ssss(stri)
     ioa=0
    #Code_by_HamzaEhteshamFarooq
     ioa+=1
     counti = stri.length()
     while ioa<counti
        if id (stri[ioa])
            ioa+=1
            if ioa == counti
                Token.push("ID,#{stri},#{Linea}")
            end
        else 
            Token.push("Invalid Token,#{stri},#{Linea}")
            break
        end
     end
end


def Analyzer(check)

    if DataType.select{|word| word == check} !=[]

        Token.push("DataType,#{check},#{Linea}")     

    elsif Keywords.select{|word| word == check} !=[]
        Token.push("#{check},#{check},#{Linea}")

    elsif Boolean.select{|word| word == check} !=[]
        Token.push("Bool,#{check},#{Linea}")

	#Code_by_HamzaEhteshamFarooq	
    
    elsif Access.select{|word| word == check} !=[]
        Token.push("Access,#{check},#{Linea}")

    elsif Encap.select{|word| word == check} !=[]
        Token.push("Encap,#{check},#{Linea}")

    elsif Seperator.select{|word| word == check} !=[]
        Token.push("#{check},#{check},#{Linea}")
    
    else 
        case check
        when '++','--'
            Token.push("Incdec,#{check},#{Linea}")
        when '+','-'
            Token.push("PM,#{check},#{Linea}")
        when '*','/','%'
            Token.push("MDM,#{check},#{Linea}")
        when '=','+=','-=','*=','%=','/='
            Token.push("ASSIOP,#{check},#{Linea}")
        when '==','<','>','<=','>=','!='
            Token.push("ROP,#{check},#{Linea}")
        when '&&','||'
            Token.push("GOP,#{check},#{Linea}")
        when '&'
            Token.push("ANO,#{check},#{Linea}")
        when '|'
            Token.push("ORO,#{check},#{Linea}")
        when '!'
            Token.push("NOP,#{check},#{Linea}")
        when /\<\</
            Token.push("SOP,#{check},#{Linea}")
        when /\>\>/
            Token.push("SOP,#{check},#{Linea}")
        when ','
            Token.push("\",\",\",\",#{Linea}")
        else
            ii=0
            genti = check.length()
            if  num(check[0])
               if genti==1
                    Token.push("Interger,#{check},#{Linea}")
               else
                ii+=1
                while ii<genti
                    if num(check[ii])
                        ii+=1
                        if ii==genti
                            Token.push("Interger,#{check},#{Linea}")
                        end
                    else   
                        Token.push("Invalid Token,#{check},#{Linea}")
                        break
                    end
                end
               end
            elsif ids(check[0])   
                if check.length()==1
                    Token.push("ID,#{check},#{Linea}")
                else
                ssss(check)
                end
            else
                Token.push("Invalid Token,#{check},#{Linea}")

             end
        end
    end
end
def period(tokenback,tokenup)
    Analyzer(tokenup)
    tokenup=Token.pop()
    takenup=tokenup.split(',')
    tampa=tokenback.split(',')
    if takenup[0]==tampa[0]
        case tampa[0]
        when 'Interger'
            tokenup=tokenup.split(',')
            tempa=tokenback.split(',')
            Token.pop()
            tempr = tempa[1]+'.'+tokenup[1]
            Token.push("Decimal,#{tempr},#{Linea}")
        else
            Token.push("period,.,#{Linea}")
            Token.push(tokenup)
        end
    else 
        Token.push("period,.,#{Linea}")
        Token.push(tokenup)
    end
end

code = File.read(%|C:\\Users\\Ehtes\\Documents\\class pro\\code.txt|)
text = code.split(/(\n)|(\\[\"\'rnbst\\])|(\/\/)|(\/\*)|(\*\/)|(\\)|( )|(\t)|(\&\&)|(\|\|)|(\+\+)|(\-\-)|([\+\-\*\/\%]\=)|(\!\=)|(\<\<)|(\>\>)|([\<\>]\=?)|(\=\=)|([\&\|\.\,\;\(\)\[\]\{\}\+\*\-\=\%\!\:\"\'\/])/)
puts text
count = text.length()
i=0

while i<count
    temp =""
    temp= text[i]
    next i+=1 if temp==" " or temp == "" 
    next i+=1 if temp =="\t"
    if temp =="\n"
        Linea+=1
        i+=1
        next
    elsif temp=="//"
        i+=1
        temp=""
        while text[i]!="\n"
            temp+=text[i]
            i+=1
            if i==count
                break
            end
        end
        i+=1
    elsif temp=="/*"
        i+=1
        temp=""
        while text[i]!="*/"
            if text[i]=="\n"
                Linea+=1
            end
            temp+=text[i]
            i+=1
            if i==count
                break
            end
        end
        i+=1
    elsif temp=='\''
        temp=""
        ini = i 
        i+=1
        while text[i]!='\'' and text[i]!="\n"
            next i+=1 if text[i]==""
            if temp==""
               temp += text[i]
              i+=1
            else
                break
            end
        end
        if text[i]=='\''
            Token.push("character,#{temp},#{Linea}")
            i+=1
        else
            i=ini
            Token.push("Invalid Token,#{text[i]},#{Linea}")
            i+=1
        end

    elsif temp=="\""
        temp=""
        ini = i 
        i+=1
        while text[i]!="\"" and text[i]!="\n"
            if text[i]=="\\"
                Token.push("Invalid Token,\\,#{Linea}")
            end
            temp +=text[i]
            i+=1
            if i>=count
                break
            end
        end 
        if text[i]=="\""
            Token.push("string,#{temp},#{Linea}")
            i+=1
        else 
            i=ini
            Token.push("Invalid Token,#{text[i]},#{Linea}")
            i+=1
        end
    elsif temp=='.'
        i+=1
        while text[i]=="" or text[i]==" " or text[i]=="\t"
            i+=1
        end
        if text[i]=="."
            puts "aasakdopaskdasd"
            Token.push("period,.,#{Linea}")
            Token.push("period,.,#{Linea}")
            i+=1
        else
        period(Token[-1],text[i])
        i+=1
        end
    else
            Analyzer(temp) 
             i+=1
    end
end
puts Token
puts text.length()
File.open("Token.csv", "w") { |f| f.write "#{Time.now} - User logged in\n" }
File.write("Token.csv", Token.join("\n"))


