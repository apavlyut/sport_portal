module AdvertisingHelper
  def context_ad
    context_ads = [
      "<a href=''>\"Империя Фитнеса\" - всё для вас!</a><br>Fitnes, спортклубы - на сайт погляди, 4 900 рублей за год цену не пропусти", 
      "<a href=''>Все фитнес клубы Москвы</a><br>Описание клубов, поиск, общение с инструкторами и посетителями, работа и др",
      "<a href=''>Фитнес вместе - фитнес сейчас!</a><br>Уже лето, а фигура атас. Спецкурс по созданию фигуры",
      "<a href=''>N-ERGO сеть фитнес-клубов</a><br>Бесплатная консультация фитнес-эксперта по программе тренировок и питанию!",
      "<a href=''>Фитнес залы Москвы</a><br>Вся информация по спортивным и тренажерным залам: метро, цены, акции.",
      "<a href=''>Спортивное питание</a><br>Спортивное питание от ведущих брендов, большой выбор, высокое качество",
      "<a href=''>Продажа спортивного питания</a><br>Оптом и в розницу! Только топовые бренды: Ultimate, Weider, Multipower и др"
      ]
    context_ads[rand(context_ads.size)] + "<br><span color='green'>www.website.com</span>"
  end
  
  def right_ad
    '<div class="ad_right">
  		<img src="/images/advertising/terra_nova_MedRec_gif.gif">
  	</div>'
  	'<div class="ad_right">
    <iframe src="http://view.atdmt.com/CNT/iview/yhxxxcbr3400000019cnt/direct;wi.300;hi.250/01/?time=1220710544817015&click=http://us.ard.yahoo.com/SIG=1522rovgg/M=685806.12971260.13191837.10542178/D=flickr/S=792600147:LREC/Y=YAHOO/EXP=1220717744/L=UqYEBtG_aVSzoJB1kuhoSxnk0b9pm0jCkJAADHPr/B=bUNRANj8Ymg-/J=1220710544817015/A=5473437/R=0/*" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" topmargin="0" leftmargin="0" allowtransparency="true" width="300" height="250">
    <SCRIPT language="JavaScript" type="text/javascript">document.write(\'<a HREF="http://us.ard.yahoo.com/SIG=1522rovgg/M=685806.12971260.13191837.10542178/D=flickr/S=792600147:LREC/Y=YAHOO/EXP=1220717744/L=UqYEBtG_aVSzoJB1kuhoSxnk0b9pm0jCkJAADHPr/B=bUNRANj8Ymg-/J=1220710544817015/A=5473437/R=1/SIG=1324i7phf/*http://clk.atdmt.com/CNT/go/yhxxxcbr3400000019cnt/direct;wi.300;hi.250/01/?time=1220710544817015" target="_blank"><img src="http://view.atdmt.com/CNT/view/yhxxxcbr3400000019cnt/direct;wi.300;hi.250/01/?time=1220710544817015"/></a>\');</script><noscript><a HREF="http://us.ard.yahoo.com/SIG=1522rovgg/M=685806.12971260.13191837.10542178/D=flickr/S=792600147:LREC/Y=YAHOO/EXP=1220717744/L=UqYEBtG_aVSzoJB1kuhoSxnk0b9pm0jCkJAADHPr/B=bUNRANj8Ymg-/J=1220710544817015/A=5473437/R=2/SIG=1324i7phf/*http://clk.atdmt.com/CNT/go/yhxxxcbr3400000019cnt/direct;wi.300;hi.250/01/?time=1220710544817015" target="_blank"><img border="0" src="http://view.atdmt.com/CNT/view/yhxxxcbr3400000019cnt/direct;wi.300;hi.250/01/?time=1220710544817015" /></a></noscript></iframe></div>'
  end
  
  
end