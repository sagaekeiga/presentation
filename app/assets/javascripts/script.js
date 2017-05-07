
$(function() {	
	/* -------------------------------------------------------
		記事の見出しから目次作成
	--------------------------------------------------------*/
	function makeMokuji() {
		
		var idcount = 1;
		var mokuji = '';
		var currentlevel = 0
		var sectionTopArr = new Array();
		
		// 見出しを回してリストに格納
		$('.mic_co_sh_post h1, .mic_co_sh_post h2, .mic_co_sh_post h3, .mic_co_sh_post h4').each(function(i){
			
			// IDを保存
			this.id = 'chapter-' + idcount;
			idcount ++;
			
			// 見出しの入れ子
			var level = 0;
			if(this.nodeName.toLowerCase() == 'h2') {
				level = 1;
			} else if(this.nodeName.toLowerCase() == 'h3') {
				level = 2;
			} else if(this.nodeName.toLowerCase() == 'h4') {
				level = 3;
			}
			while(currentlevel < level) {
				mokuji += '<ol class="chapter">';
				currentlevel ++;
			}
			while(currentlevel > level) {
				mokuji += '</ol>';
				currentlevel --;
			}
			
			// リストを生成
			mokuji += '<li><a href="#' + this.id + '">' + $(this).html() + '</a></li>\n';
		});
	
		while(currentlevel > 0) {
			mokuji += '</ol>';
			currentlevel --;
		}	
				
		// HTML出力
		strMokuji = '<h4>目次</h4>'
						+ mokuji +
					 '<!-- /.mokujiInner --></div>';
					
		$('.mokuji').html(strMokuji);
		
		/* -------------------------------------------------------
			リストクリックでスムーズスクロール
		--------------------------------------------------------*/
		$('.mokuji li').not('.accordion, .accBtn').click(function(){
			var speed = 800;
			var href = $(this).find('a').attr('href');
			var target = $(href == '#' || href == '' ? 'html' : href);
			var position = target.offset().top;
			$('html, body').stop().animate({scrollTop:position}, speed, 'easeInOutCirc');
			return false;
		});
		
		/* -------------------------------------------------------
			目次のアコーディオン
		--------------------------------------------------------*/
		$('.mokuji ol').prev().addClass('accordion').append('<span class="accBtn"><i class="fa fa-plus-square-o"></i></span>');
		$('.mokuji li.accordion').wrapInner('<div class="inner clearfix"></div>');
		
		// 開閉ボタンを押した時
		$('.accBtn').click(function(){
			
			// 開閉処理
			$(this).parents('li').next().stop().slideToggle(300, 'easeInOutCirc');
			
			// 閉じるボタンアイコン切替
			$('.closeBtn').removeClass('active').addClass('active');
			
			// アイコン切替
			if( $(this).find('i').hasClass('fa-plus-square-o') ){
				$(this).find('i').removeClass('fa-plus-square-o').addClass('fa-minus-square-o');
			} else {
				$(this).find('i').removeClass('fa-minus-square-o').addClass('fa-plus-square-o');
			}
			return false;
		});
		
		// 閉じるボタンの表示切替
		var closeBtnFlag = '';
		$('.mokuji li').each(function() {
			if( $(this).hasClass('accordion') ) {
				closeBtnFlag = false;
			}
		});
		if( closeBtnFlag == true ) {
			$('.closeBtn').hide();
		}
		
		// 全て閉じるボタンを押した時
		$('.closeBtn').click(function(){
			
			// 閉じるアイコン切替
			$(this).toggleClass('active');

			// classの有無を確認
			if( $(this).hasClass('active') ){
				$('.mokuji ol ol').stop().slideDown(300, 'easeInOutCirc');
				$('.accBtn').find('i').removeClass('fa-plus-square-o').addClass('fa-minus-square-o');

			} else {
				$('.mokuji ol ol').stop().slideUp(300, 'easeInOutCirc');
				$('.accBtn').find('i').removeClass('fa-minus-square-o').addClass('fa-plus-square-o');
			}

		});
		
		/* -------------------------------------------------------
			カレント表示切替
		--------------------------------------------------------*/
		var secTopArr = new Array();
		secTopArr.length = 0;
		var current = -1;
	
		// 現在位置の取得
		$('article [id^="chapter"]').each(function(i){
			secTopArr[i] = $(this).offset().top;
		});
	
		//スクロールイベント
		$(window).on('load scroll',function(){
			for (var i = secTopArr.length-1; i>=0; i--) {
				if ($(window).scrollTop() > secTopArr[i] - 20) {
					$('.mokuji li').removeClass('current').eq(i).addClass('current');
					$('.mokuji ol ol li.current').parent('ol').prev().addClass('current');
					break;
				}
			}
		});
	}
	makeMokuji();
			
	/* -------------------------------------------------------
		目次固定
	--------------------------------------------------------*/
	function fixedSide() {
		
		// ウィンドウ幅・人気記事を取得
		var w = window.innerWidth;
		var mainH = $('#main').height();
		var sideH = $('#side').height();
		var fixedElm = '';
		
		if(mainH > sideH) { // サイドバーより長ければ
		
			fixedElm = $('.mokuji');
							
			// 要素の位置を取得
			var fixedSideTop = fixedElm.offset().top;
			var footerTop = $('footer').offset().top;
			var scrollBottom = $('body').height() - $(window).height() - $('footer').outerHeight();
			
			$(window).scroll(function(){

				// スクロール位置を取得
				y = $(window).scrollTop();
				
				// スクロールがサイドバーを上回ったら
				if(y > fixedSideTop){
					fixedElm.addClass('fixed-side');
				} else {
					fixedElm.removeClass('fixed-side');
				}
			});
		}
	}
	fixedSide();
});