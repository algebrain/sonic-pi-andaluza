tf = 0.23   # минимальная длительность

ra = 0.2    # время затухания щипка
rb = 2 - ra

t1 = 0.15   # время звучания щипка
t2 = 2 - t1

# средняя партия
middle = [
  [:pan, 0.7],
  [:amp, 0.3],
  
  # 1
  [nil, 6],
  [nil],
  [[:g3, :b3]],
  [nil],
  [[:g3, :b3]],
  [nil],
  [[:g3, :b3]],
  
  # 2
  [[:g3, :b3], 6],
  [nil],
  [[:g3, :b3]],
  [nil],
  [[:g3, :b3]],
  [nil],
  [[:g3, :b3]],
  
  # 3
  [[:g3, :b3], 2],
  [nil],
  [[:g3, :b3]],
  [nil],
  [[:g3, :b3]],
  [nil],
  [[:g3, :b3]],
  [nil],
  [[:g3, :b3]],
  [nil],
  [[:g3, :b3]],
  
  #4
  [nil],
  [[:b3, :e4]],
  [nil],
  [[:b3, :e4]],
  [nil],
  [[:b3, :e4]],
  [nil],
  [[:c4, :e4]],
  [nil],
  [[:c4, :e4]],
  [nil],
  [[:c4, :e4]],
  
  #5
  [nil],
  [[:a3, :b3]],
  [nil],
  [[:g3, :b3]],
  [nil],
  [[:g3, :b3]],
  [nil],
  [[:g3, :b3]],
  [nil],
  [[:g3, :b3]],
  [nil],
  [[:g3, :b3]],
  
  #6
  [nil],
  [[:g3, :b3]],
  [nil],
  [[:g3, :b3]],
  [nil],
  [[:g3, :b3]],
  [nil],
  [[:g3, :b3]],
  [nil],
  [[:g3, :b3]],
  [nil],
  [[:g3, :b3]],
  
  #7
  [nil],
  [[:b3, :e4]],
  [nil],
  [[:b3, :e4]],
  [nil],
  [[:b3, :e4]],
  [nil],
  [[:c4, :e4]],
  [nil],
  [[:c4, :e4]],
  [nil],
  [[:c4, :e4]],
  
  #8
  [nil],
  [[:a3, :b3]],
  [nil],
  [[:g3, :b3]],
  [nil],
  [[:g3, :b3]],
  [nil],
  [[:g3, :b3]],
  [nil],
  [[:g3, :b3]],
  [nil],
  [[:g3, :b3]],
  
]

# нижняя партия

ch12 = [
  [:add, -0.1],
  [:as2, t1, 0.4, ra],
  [:b2,  t2, 0.5, rb],
]

ch123 = [
  *ch12,
  *ch12,
  *ch12,
  *ch12,
  *ch12,
]

lower = [
  [:pan, -0.7],
  # 1
  [:amp, 0.4],
  [:e2,  2],
  *ch123,
  
  # 2
  [:e2,  2],
  *ch123,
  
  # 3
  [:amp, 0.3],
  [:e2,  2],
  *ch123,
  
  # 4
  [:e2,  2],
  [:g3,  2],
  [:b2,  2],
  [:fs2, 2],
  [:fs3, 2],
  [:fs2, 2],
  
  # 5
  [:b2,  2],
  [:e2,  2],
  [:b2,  2],
  [:b2,  2],
  [:b2,  2],
  [:b2,  2],
  
  # 6
  [:e2,  2],
  *ch123,
  
  # 7
  [:e2,  2],
  [:g3,  2],
  [:b2,  2],
  [:fs2, 2],
  [:fs3, 2],
  [:e3,  2],
  
  # 5
  [:d3,  2],
  [:g2,  2],
  [:d3,  2],
  [:d3,  2],
  [:d3,  2],
  [:d3,  2],
  
]


# главная партия
main = [
  #1
  [nil,  12],
  
  #2
  [nil,  12],
  
  #3
  [nil,  9],
  [:amp, 0.4],
  [:cre, 1.0, 3],
  [:e3],
  [:fs3],
  [:g3],
  
  #4
  [:b3,  2],
  [:amp, 1],
  [:b3,  3],
  [:a3],
  [:b3,  2],
  [:a3,  4],
  
  #5
  [:b3],
  [:amp, 0.4],
  [:eb3],
  [:amp, 0.6],
  [:e3,  10, 4],
  
  #6
  [nil,  9],
  [:amp, 0.4],
  [:cre, 1.0, 3],
  [:e3],
  [:fs3],
  [:g3],
  
  #7
  [:b3,  2],
  [:amp, 1],
  [:b3,  3],
  [:a3],
  [:b3,  2],
  [:a3,  4],
  
  #8
  [:b3],
  [:amp, 0.4],
  [:fs3],
  [:amp, 0.6],
  [:d3,  10],
]

define :play_melody_ do |m, s = :pluck|
  use_synth s if s
  amp = 1 # громкость
  pan = 0 # баланс
  add = 0 # временная добавка громкости
  ph =  0 # фаза крещендо/диминуэндо
  str = 0 # сила крещендо/диминуэндо
  len = 0 # длительность крещендо/диминуэндо
  
  m.each { |n|
    op, *rest = n
    
    case op
    when :amp
      amp, *r = rest
      next
    when :pan
      pan, *r = rest
      next
    when :add
      add, *r = rest
      next
    when :cre
      str, len, *r = rest
      next
    when :dim
      str, len, *r = rest
      str = -str
      next
    end
    
    t, rel, *r = rest
    t = t.nil? ? 1 : t
    if op.nil?
      sleep tf*t
      next
    end
    
    rel = rel.nil? ? 1 : rel
    a = amp + add
    a += ph*str*a
    
    if op.kind_of?(Array)
      play_chord(op, amp: a, pan: pan, release: rel)
    else
      play op, amp: a, pan: pan, release: rel
    end;
    
    add = 0
    if str != 0
      if ph >= 1
        ph = 0
        len = 0
        str = 0
      else
        ph += t.to_f/len
      end
    end
    
    sleep tf*t
  }
end;

with_fx :reverb, mix: 0.7 do
  in_thread do
    play_melody_ lower, :piano
  end
  
  in_thread do
    play_melody_ middle #, :piano
  end
end

with_fx :reverb, mix: 0.76 do
  play_melody_ main
end
