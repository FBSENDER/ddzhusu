window.PCOUNT = 0;
window.set_jwplayer = function(src){
  var ww = document.getElementById('ykplayer0').clientWidth;
  var hh = ww*0.5625;
  var tt = 'mp4';
  if(src.indexOf('/flv/') > 0)
    tt = 'flv';
  var jwp = jwplayer('ykplayer' + PCOUNT)
    jwp.setup({
      file:src,
      type:tt,
      height: hh,
      width: ww,
      players:[
    {type: "flash", src: '/jwplayer/jwplayer.flash.swf'},
      {type: 'html5'}
    ],
    });
  if(PCOUNT == 0){
    jwp.on('error',function(e){
      if(e.message == 'Error loading media: File could not be played'){
        $('#ykplayer0').append("<div class='hidden'><iframe src='http://www.youku.com'></iframe></div>");
        $('div.jw-title-primary.jw-reset').html("服务器开小差了，请刷新页面试一试~");
        $('#source_link_p_' + PCOUNT).removeClass('hidden');
        var lk = $('#source_link_a_' + PCOUNT).data('original');
        $('#source_link_a_' + PCOUNT).attr({href: lk});
      }
    });
  }
  else{
    jwp.on('error',function(e){
      if(e.message == 'Error loading media: File could not be played'){
        $('#source_link_p_' + PCOUNT).removeClass('hidden');
        var lk = $('#source_link_a_' + PCOUNT).data('original');
        $('#source_link_a_' + PCOUNT).attr({href: lk});
      }
    });
  }

  PCOUNT += 1;
};
