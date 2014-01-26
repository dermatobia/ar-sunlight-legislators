require './models/legislator.rb'
require 'pry'

def state_legs(state)
  puts "Senators of #{state}:"
  Legislator.where(state: state, title:'Sen').sort{|x,y| x.lastname<=>y.lastname}.each do |sen|
    puts "  #{sen.firstname} #{sen.lastname}  (#{sen.party})"
  end

  puts "Rep of #{state}:"
  Legislator.where(state: state,title:'Rep').sort{|x,y| x.lastname<=>y.lastname}.each do |rep|
    puts "  #{rep.firstname} #{rep.lastname}  (#{rep.party})"
  end
end

def gender_stats(gender)
  total_sen = Legislator.where(title:'Sen').count.to_f
  total_rep = Legislator.where(title:'Rep').count.to_f
  sen_by_gender =  Legislator.where(gender: gender, title: 'Sen').count
  rep_by_gender =  Legislator.where(gender: gender, title:'Rep').count
  if gender == "M"
    gender = "Male"
  else
    gender = "Female"
  end
  puts "#{gender} Senators: #{sen_by_gender} (#{(sen_by_gender/total_sen * 100).to_i}%)"
  puts "#{gender} Representatives: #{rep_by_gender} (#{(rep_by_gender/total_rep * 100).to_i}%)"

end

def display_active
  states = Legislator.distinct.pluck(:state)
  totals = {}
  states.each do |state|
    totals[state.to_sym] = Legislator.where(state:state,title:'Rep',in_office: true).count
  end
  totals = totals.sort{|x,y| y[1] <=> x[1]}
  totals.each do |state|
    puts "#{state[0].to_s}: 2 Senators,  #{state[1]} Representative(s)"
  end
end

def totals
  sen = Legislator.where(title: 'Sen').count
  rep = Legislator.where(title: 'Rep').count

  puts "Senators: #{sen}"
  puts "Representatives: #{rep}"
end

def destroy_inactive
  Legislator.where(in_office: false).each{|leg| leg.destroy}
  totals
end


gender_stats("F")
gender_stats("M")


