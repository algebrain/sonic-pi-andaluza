tf = 0.23   # минимальная длительность

ra = 0.2    # время затухания щипка
rb = 2 - ra

t1 = 0.15   # время звучания щипка
t2 = 2 - t1

PAN = 0.2

# нижняя партия

ch12 = [ [:add, -0.1], [:as2, t1, ra], [:b2,  t2, rb] ]
ch123 = [ *ch12, *ch12, *ch12, *ch12, *ch12 ]

lower = [
  [:pan, -PAN],
  
  #1 /0
  [:amp, 0.4], [:e2,  2], *ch123,
  #2 /12
  [:e2,  2], *ch123,
  #3 /24
  [:amp, 0.3], [:e2,  2], *ch123,
  #4 /36
  [:e2,  2], [:g3,  2], [:b2,  2], [:fs2, 2], [:fs3, 2], [:fs2, 2],
  #5 /48
  [:b2,  2], [:e2,  2], [:b2,  2], [:b2,  2], [:b2,  2], [:b2,  2],
  #6 /60
  [:e2,  2], *ch123,
  #7 /72
  [:e2,  2], [:g3,  2], [:b2,  2], [:fs2, 2], [:fs3, 2], [:e3,  2],
  #8 /84
  [:d3,  2], [:g2,  2], [:d3,  2], [:d3,  2], [:d3,  2], [:d3,  2],
  #9 /96
  [:a3,  2], [:d3,  2], [:a3,  2], [:d3,  2], [:a3,  2], [:a3,  2],
  #10 /102
  [:c3,  2], [:e3,  2], [:c3,  2], [:e3,  2], [:c3,  2], [:a2,  2],
  #11 /120
  :e2, :b2, :g3, :b2, :g3, :b2, :g3, :b2, :g3, :b2, :g3, :b2,
]

# средняя партия
middle = [
  [:coe, 0.2],
  [:pan, PAN],
  [:amp, 0.3],
  
  # 1 /0
  [nil, 6], nil, [[:g3, :b3]], nil, [[:g3, :b3]], nil, [[:g3, :b3]],
  # 2 /12
  [[:g3, :b3], 6], nil, [[:g3, :b3]], nil, [[:g3, :b3]], nil, [[:g3, :b3]],
  # 3 /24
  [[:g3, :b3], 2], nil, [[:g3, :b3]], nil, [[:g3, :b3]], nil, [[:g3, :b3]], nil, [[:g3, :b3]], nil, [[:g3, :b3]],
  #4 /36
  nil, [[:b3, :e4]], nil, [[:b3, :e4]], nil, [[:b3, :e4]], nil, [[:c4, :e4]], nil, [[:c4, :e4]], nil, [[:c4, :e4]],
  #5 /48
  nil, [[:a3, :b3]], nil, [[:g3, :b3]], nil, [[:g3, :b3]], nil, [[:g3, :b3]], nil, [[:g3, :b3]], nil, [[:g3, :b3]],
  #6 /60
  nil, [[:g3, :b3]], nil, [[:g3, :b3]], nil, [[:g3, :b3]], nil, [[:g3, :b3]], nil, [[:g3, :b3]], nil, [[:g3, :b3]],
  #7 /72
  nil, [[:b3, :e4]], nil, [[:b3, :e4]], nil, [[:b3, :e4]], nil, [[:c4, :e4]], nil, [[:c4, :e4]], nil, [[:c4, :e4]],
  #8 /84
  nil, [[:c4, :d4]], nil, [[:g3, :b3, :d4]], nil, [[:g3, :b3]], nil, [[:g3, :b3]], nil, [[:g3, :b3]], nil, [[:g3, :b3]],
  #9 /96
  nil, [[:a3, :d4]], nil, [[:a3, :d4]], nil, [[:a3, :d4]], nil, [[:a3, :d4]], nil, [[:a3, :d4]], nil, [[:a3, :d4]],
  #10 /102
  nil, [[:g3, :c4]], nil, [[:g3, :c4]], nil, [[:g3, :c4]], nil, [[:g3, :c4]], nil, [[:g3, :c4]], nil, [[:g3, :c4]],
  #11 /120
  [nil, 12],
]

# главная партия
main = [
  [:coe, 0.45],

  #1 /0
  [nil,  12],
  #2 /12
  [nil,  12],
  #3 /24
  [nil,  9], [:cre, 0.7, 4, 1], [:e3, 0.8], [:fs3, 1.2], [:g3, 0.8],
  #4 /36
  [:b3,  2.2], [:b3,  3], :a3, [:b3,  2], [:a3,  4],
  #5 /48
  :b3, [:set, 0.4], :eb3, [:set, 0.6], [:e3,  10, 4],
  #6 /60
  [nil,  9], [:cre, 0.7, 4, 1], [:e3, 0.8], [:fs3, 1.2], [:g3, 0.8],
  #7 /72
  [:b3,  2.2], [:b3,  3], :a3, [:b3,  2], [:a3,  4],
  #8 /84
  :b3, [:set, 0.4], :fs3, [:set, 0.6], [:d3,  10],
  #9 /96
  :d3, :fs3, [:a3, 7], :fs3, [:cre, 0.7, 2, 1], [:e3, 0.2, 0.23], [:e3, 0.2, 0.23], [:e3, 0.6], :fs3,
  #10 /102
  [:g3, 10], :fs3, :e3,
  #11 /120
  :g3, [:b4, 11],
]

sta = 0
fin = 0

define :play_melody_ do |m|
  coe = 0.3 # coef

  amp = 1 # громкость
  pan = 0 # баланс
  set = 0 # временное значение громкости
  add = 0 # временная добавка громкости
  per = 0 # временная добавка прооцента громкости
  
  str = 0 # сила крещендо/диминуэндо
  dur = 0 # длительность крещендо/диминуэндо
  tar = 0 # цель крещендо/диминуэндо
  
  count = 0
  
  m.each { |n|
    op, *rest = n.kind_of?(Array) ? n : [n]
    
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
    when :set
      set, *r = rest
      next
    when :per
      per, *r = rest
      next
    when :coe
      coe, *r = rest
      next
    when :cre
      str, dur, tar, *r = rest
      amp = tar - str
      next
    when :dim
      str, dur, tar, *r = rest
      str = -str
      amp = tar - str
      next
    end
    
    t, rel, *r = rest
    t = t.nil? ? 1 : t
    
    skip = (sta > 0 && count < sta) || (fin > 0 && count >= fin)
    count += t
    next if skip
    
    if op.nil?
      sleep tf*t
      next
    end
    
    rel = rel.nil? ? 1 : rel
    
    a = amp
    if set > 0
      a = set
    elsif per > 0
      a += a*(per.to_f/100)
    elsif add > 0
      a += add
    end
    
    if op.kind_of?(Array)
      play_chord(op, amp: a, pan: pan, release: rel, coef: coe)
    else
      play op, amp: a, pan: pan, release: rel, coef: coe
    end;
    
    add = 0
    per = 0
    set = 0
    
    if tar > 0
      if amp >= tar
        amp = tar
        dur = 0
        str = 0
        tar = 0
      else
        amp += str.to_f/dur
        if amp > tar
          amp = tar
        end
      end
    end
    
    sleep tf*t
  }
end;

define :play_main_ do
  in_thread do
    use_synth :pluck
    with_fx :reverb, mix: 0.76 do
      play_melody_ main
    end
  end
end

define :play_lower_ do
  in_thread do
    use_synth :piano
    with_fx :reverb, mix: 0.7 do
      play_melody_ lower
    end
  end
end

define :play_middle_ do
  in_thread do
    use_synth :pluck
    with_fx :reverb, mix: 0.7 do
      play_melody_ middle
    end
  end
end

play_lower_
play_middle_
play_main_

#play_melody_ []