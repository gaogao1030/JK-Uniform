$ ->
  $btn_audio = $("#btnAudio")
  $group_icon = $(".group-icon")
  $loading = $("#musicLoading")
  sound = undefined
  $group_icon.on "click", ->
    state = $btn_audio.data("play")
    switch state
      when "init"
        $loading.removeClass("hidden")
        $btn_audio.addClass("hidden")
        $group_icon.addClass("loading")
        $btn_audio.data("play","loading")
        sound = new Howl({
          urls: ["http://7xl9ad.com1.z0.glb.clouddn.com/mp3-放課後ティータイム%20-%20ふわふわ時間(映画｢けいおん!｣Mix)%20-%20remix.mp3"]
          volume: 0.5
          onload: ->
            $btn_audio.data("play","playing")
            $group_icon.removeClass("loading")
            $loading.addClass("hidden")
            $btn_audio.removeClass("hidden")
            $btn_audio.removeClass("glyphicon-play")
            $btn_audio.addClass("glyphicon-pause")
          onloaderror: ->
            alert "loading failed"
          onend: ->
            $btn_audio.data("play","init")
            $btn_audio.removeClass("glyphicon-pause")
            $btn_audio.addClass("glyphicon-play")
        })
        sound.play()
      when "playing"
        $btn_audio.data("play","pause")
        $btn_audio.removeClass("glyphicon-pause")
        $btn_audio.addClass("glyphicon-play")
        sound.pause()
      when "pause"
        $btn_audio.data("play","playing")
        $btn_audio.removeClass("glyphicon-play")
        $btn_audio.addClass("glyphicon-pause")
        sound.play()


