// 侧边导航目录
jQuery(function($) {
	$(document).ready(function() {
		var contentButton = [];
		var contentTop = [];
		var content = [];
		var lastScrollTop = 0;
		var scrollDir = '';
		var itemClass = '';
		var itemHover = '';
		var menuSize = null;
		var stickyHeight = 0;
		var stickyMarginB = 0;
		var currentMarginT = 0;
		var topMargin = 0;
		var vartop = 0;
		$(window).scroll(function(event) {
			var st = $(this).scrollTop();
			if (st > lastScrollTop) {
				scrollDir = 'down';
			} else {
				scrollDir = 'up';
			}
			lastScrollTop = st;
		});
		$.fn.stickUp = function(options) {
			$(this).addClass('stuckMenu');
			var objn = 0;
			if (options != null) {
				for (var o in options.parts) {
					if (options.parts.hasOwnProperty(o)) {
						content[objn] = options.parts[objn];
						objn++;
					}
				}
				if (objn == 0) {
					console.log('error:needs arguments');
				}
				itemClass = options.itemClass;
				itemHover = options.itemHover;
				if (options.topMargin != null) {
					if (options.topMargin == 'auto') {
						topMargin = parseInt($('.stuckMenu').css('margin-top')) + 70;
					} else {
						if (isNaN(options.topMargin) && options.topMargin.search("px") > 0) {
							topMargin = parseInt(options.topMargin.replace("px", ""));
						} else if (!isNaN(parseInt(options.topMargin))) {
							topMargin = parseInt(options.topMargin);
						} else {
							console.log("incorrect argument, ignored.");
							topMargin = 0;
						}
					}
				} else {
					topMargin = 0;
				}
				menuSize = $('.' + itemClass).size();
			}
			stickyHeight = parseInt($(this).height());
			stickyMarginB = parseInt($(this).css('margin-bottom'));
			currentMarginT = parseInt($(this).next().closest('div').css('margin-top'));
			vartop = parseInt($(this).offset().top);
		};
		$(document).on('scroll', function() {
			varscroll = parseInt($(document).scrollTop());
			if (menuSize != null) {
				for (var i = 0; i < menuSize; i++) {
					contentTop[i] = $('#' + content[i] + '').offset().top;

					function bottomView(i) {
						contentView = $('#' + content[i] + '').height() * .4;
						testView = contentTop[i] - contentView;
						if (varscroll > testView) {
							$('.' + itemClass).removeClass(itemHover);
							$('.' + itemClass + ':eq(' + i + ')').addClass(itemHover);
						} else if (varscroll < 50) {
							$('.' + itemClass).removeClass(itemHover);
							$('.' + itemClass + ':eq(0)').addClass(itemHover);
						}
					}
					if (scrollDir == 'down' && varscroll > contentTop[i] - 50 && varscroll < contentTop[i] + 50) {
						$('.' + itemClass).removeClass(itemHover);
						$('.' + itemClass + ':eq(' + i + ')').addClass(itemHover);
					}
					if (scrollDir == 'up') {
						bottomView(i);
					}
				}
			}
			if (vartop < varscroll + topMargin) {
				$('.stuckMenu').addClass('isStuck');
				$('.stuckMenu').next().closest('div').css({
					'margin-top': stickyHeight + stickyMarginB + currentMarginT + 'px'
				}, 10);
				$('.stuckMenu').css("position", "fixed");
				$('.isStuck').css({
					top: '0px'
				}, 10, function() {});
			} else {
				$('.stuckMenu').removeClass('isStuck');
				$('.stuckMenu').next().closest('div').css({
					'margin-top': currentMarginT + 'px'
				}, 10);
				$('.stuckMenu').css("position", "relative");
			};
		});
	});
});
function loadScroller() {
	if ($("#topics").length > 0) {
		$('#sideBarMain').remove();
		//先获取第一个h标签, 之后循环时作为上一个h标签
		var $ph = $('#cnblogs_post_body :header:eq(0)');
		if ($ph.length > 0) {
			//设置层级为1
			$ph.attr('offset', '1');
			//添加导航目录的内容
			$('#sideBar').append(
				'<div id="sidebar_scroller" class="catListPostArchive sidebar-block"><h3 class="catListTitle">导航目录</h3><ul class="nav"></ul></div>'
			);
			//取当前边栏的宽度
			$('#sidebar_scroller').css('width', ($('#sideBar').width() - 40) + 'px');
			//让导航目录停留在页面顶端
			$('#sidebar_scroller').stickUp();
			//遍历文章里每个h标签
			$('#cnblogs_post_body :header').each(function(i) {
				var $h = $(this);
				//设置h标签的id, 编号从0开始
				$h.attr('id', 'scroller-' + i);
				//比上一个h标签层级小, 级数加1
				if ($h[0].tagName > $ph[0].tagName) {
					$h.attr('offset', parseInt($ph.attr('offset')) + 1);
				} //比上一个h标签层级大, 级数减1
				else if ($h[0].tagName < $ph[0].tagName) {

					var h = parseInt($h[0].tagName.substring(1));
					var ph = parseInt($ph[0].tagName.substring(1));

					var offset = parseInt($ph.attr('offset')) - (ph - h);
					if (offset < 1) {
						offset = 1
					};
					$h.attr('offset', offset);
				} //和上一个h标签层级相等时, 级数不变
				else {
					$h.attr('offset', $ph.attr('offset'));
				}
				//添加h标签的目录内容
				$('#sidebar_scroller ul').append('<li class="scroller-offset' + $h.attr('offset') + '"><a href="#scroller-' +
					i +
					'">' + $h.text() + '</a></li>');
				//最后设置自己为上一个h标签
				$ph = $h;
			});

			//开启滚动监听, 监听所有在.nav类下的li
			$('body').scrollspy();

		}
	}
}
function setPostSideBar() {
	setTimeout(function() {
		loadScroller();
	}, 20);
}

// 设置博文内部表格滚动
function tableScorll() {
	if ($("#topics") != null) {
		$("table").each(function() {
			$(this).wrapAll('<div class="tablebox"></div>')
			$(".tablebox").css('overflow', 'auto');
		});
	}
};

// 设置手机端导航栏样式
function setMobileHeader() {
	var w = document.body.clientWidth;

	if (w <= 361) {
		$('#navList').css('display', 'none');
		$('#header').append(
			'<div class="dropdown">' +
			' <span><i class="fa fa-bars fa-lg"></i></span>' +
			' <div class="dropdown-content">' +
			$("#navList").html() +
			'  </div>' +
			'</div>')

	}
}



// 博文内部代码块复制
function copyCode() {
	if ($("#topics") != null) {
		for (i = 0; i <= $('pre').length; i++) {
			$('pre').eq(i).before('<div class="clipboard-button" id="copy_btn_' + i + ' " data-clipboard-target="#copy_target_' +
				i + '"title="复制代码">复制代码</div>');

			$('pre').eq(i).attr('id', 'copy_target_' + i);
		}
		$('.clipboard-button').css({
			"background-color": "white",
			"padding": "4px",
			"border": "1px solid #fff",
			"border-radius": "2px",
			"text-align": "right",
			"user-select": " none"
		})

		var clipboard = new ClipboardJS('.clipboard-button');
		clipboard.on('success', function(e) {

			e.trigger.innerHTML = '复制成功！';
			setTimeout(function() {
				e.trigger.innerHTML = '复制代码';
			}, 2 * 1000);

			e.clearSelection();
		});

		clipboard.on('error', function(e) {
			e.trigger.innerHTML = '复制失败！';
			setTimeout(function() {
				e.trigger.innerHTML = '复制代码';
			}, 2 * 1000);

			e.clearSelection();
		});
	}
};

// 设置博文内部链接新窗口打开
function blankTarget() {
	if ($("#topics") != null) {
		$('#cnblogs_post_body a[href^="http"]').each(function() {
			$(this).attr('target', '_blank');
		});
	}
}


// 视频解析
function jiexi1() {
	var url = document.getElementById("url").value;
	document.getElementById("iframe_jiexi").src = "https://api.sigujx.com/?url=" + url;
}
function jiexi2() {
	var url = document.getElementById("url").value;
	document.getElementById("iframe_jiexi").src = "https://jx.lache.me/cc/?url=" + url;
}
function jiexi3() {
	var url = document.getElementById("url").value;
	document.getElementById("iframe_jiexi").src = "https://jx.618g.com/?url=" + url;
}

// 修改博文发布信息位置
function changePublishinfo() {
	if ($("#topics") != null) {
		$(function() {
			//延迟1秒加载, 等博客园的侧栏加载完毕, 不然导航目录距离顶部的高度会不对
			setTimeout(function() {
				$(".postDesc").insertBefore($("#cnblogs_post_body"));
				$("#BlogPostCategory").insertBefore($("#cnblogs_post_body"));
				$("#EntryTag").insertBefore($("#cnblogs_post_body"));

			}, 100);
		})
	};
};

// 设置评论区头像
function commentIcon() {
	if ($(".blog_comment_body").length) {
		addImage();
	} else {
		var intervalId = setInterval(function() {
			if ($('.blog_comment_body').length) { //如果存在了
				clearInterval(intervalId); // 则关闭定时器
				commentIcon(); //执行自身
			}
		}, 100);
	}
}
function addImage() {
	var spen_html = "<span class='bot' ></span>\<span class='top'></span>";
	$(".blog_comment_body").append(spen_html);

	$(".blog_comment_body").before(
		"<div class='body_right' style='float: left; margin-right:20px;'><a target='_blank'><img  style='border-radius:50%;'/></a></div>"
	);
	var feedbackCon = $(".feedbackCon").addClass("clearfix");
	for (var i = 0; i < feedbackCon.length; i++) {
		var span = $(feedbackCon[i]).find("span:last")[0].innerHTML || "http://pic.cnitblog.com/face/sample_face.gif";
		$(feedbackCon[i]).find(".body_right img").attr("src", span);
		var href = $(feedbackCon[i]).parent().find(".comment_date").next().attr("href");
		$(feedbackCon[i]).find(".body_right a").attr("href", href);

	}
}

// 设置手机端目录功能栏
function loadMobileContent() {
	var w = document.body.clientWidth;
		if ((w <= 361) && ($('#sidebar_scroller') != null)) {
			$('#cnblogs_post_body').append(
				'<div class="mytoolbar"><ul id="toolbtn"><li><a href="#top">返回顶部</a></li><li onclick="showContent()">目录</li><li><a href="#footer">返回底部</a></li></ul></div>'
			);
		}
}
function showContent() {

	if ($('#sidebar_scroller').css('display') == 'none') {
		$('#sidebar_scroller').css('display', 'block');
	} else {
		$('#sidebar_scroller').css('display', 'none');
	}
}


// 设置顶部导航栏
function setHeader() {
	$("#header").each(function() {
		$(this).wrapAll('<div class="headbox"></div>')
		$(".headbox").css({
			"width": "100%",
			"height": "50px",
			"line-height": "50px",
			"background-color": "white",
		});
	});
}

// 导航栏扩展
function extendNav(mynav) {
	var str = '';
	for (var i = 0; i < mynav.length; i++) {
		str = str + '<li><a id="' + mynav[i].id + '" class="menu" href="' + mynav[i].url + '">' + mynav[i].title +
			'</a></li>';
	}
	$('#navList').append(str);
}

// 设置首页轮播
function loadBanner(mybanner) {
	var str =
		'<div class="comiis_wrapad" id="slideContainer">' +
		'<div id="frameHlicAe" class="frame cl">' +
		'<div class="temp"></div>' +
		'<div class="block">' +
		'<div class="cl">' +
		'<ul class="slideshow" id="slidesImgs">' +
		'<li>' +
		'<a href="' +
		mybanner[0].url + 'target="_blank">' +
		'<img src="' + mybanner[0].img + '"  alt="" />' +
		'</a>' +
		'<span class="title">' + mybanner[0].title + '</span>' +
		'</li>' +
		'<li>' +
		'<a href="' +
		mybanner[1].url + 'target="_blank">' +
		'<img src="' + mybanner[1].img + '"  alt="" />' +
		'</a>' +
		'<span class="title">' + mybanner[1].title + '</span>' +
		'</li>' +
		'<li>' +
		'<a href="' +
		mybanner[2].url + 'target="_blank">' +
		'<img src="' + mybanner[2].img + '"  alt="" />' +
		'</a>' +
		'<span class="title">' + mybanner[2].title + '</span>' +
		'</li>' +
		'<li>' +
		'<a href="' +
		mybanner[3].url + 'target="_blank">' +
		'<img src="' + mybanner[3].img + '"  alt="" />' +
		'</a>' +
		'<span class="title">' + mybanner[3].title + '</span>' +
		'</li>' +
		'<li>' +
		'<a href="' +
		mybanner[4].url + 'target="_blank">' +
		'<img src="' + mybanner[4].img + '"  alt="" />' +
		'</a>' +
		'<span class="title">' + mybanner[4].title + '</span>' +
		'</li>' +
		'</ul>' +
		'</div>' +
		'<div class="slidebar" id="slideBar">' +
		'<ul>' +
		'<li class="on">1</li>' +
		'<li>2</li>' +
		'<li>3</li>' +
		'<li>4</li>' +
		'<li>5</li>' +
		'</ul>' +
		'</div>' +
		'</div>' +
		'</div>' +
		'</div>';

	if ($('.day').length > 0) {
		$('.forFlow').prepend($(str)) //首页轮播
	}

	function SlideShow(c) {
		var a = document.getElementById("slideContainer"),
			f = document.getElementById("slidesImgs").getElementsByTagName("li"),
			h = document.getElementById("slideBar"),
			n = h.getElementsByTagName("li"),
			d = f.length,
			c = c || 3000,
			e = lastI = 0,
			j, m;

		function b() {
			m = setInterval(function() {
				e = e + 1 >= d ? e + 1 - d : e + 1;
				g()
			}, c)
		}

		function k() {
			clearInterval(m)
		}

		function g() {
			f[lastI].style.display = "none";
			n[lastI].className = "";
			f[e].style.display = "block";
			n[e].className = "on";
			lastI = e
		}
		f[e].style.display = "block";
		a.onmouseover = k;
		a.onmouseout = b;
		h.onmouseover = function(i) {
			j = i ? i.target : window.event.srcElement;
			if (j.nodeName === "LI") {
				e = parseInt(j.innerHTML, 10) - 1;
				g()
			}
		};
		b()
	};

	if ($('.day').length > 0) {
		SlideShow(3000);
	}


	function stopss() {
		return false;
	}
	document.oncontextmenu = stopss;
}
// 设置网页tab图标
function setFavio(myprofile) {
	$('head').append($('<link rel="shortcut icon" type="image/x-icon"/>').attr('href', myprofile[0].blogAvatar));
};

// 设置侧边栏公告个人信息
function loadProfile(myprofile) {
	var str = '<div class="myprofile">' +
		'<div class="myprofile-top">' +
		'<a class="avatar" href="https://home.cnblogs.com/u/' + myprofile[0].blogName + '/ ">' +
		'<img src="' + myprofile[0].blogAvatar + '" alt="240">' +
		'</a>' +
		'<div class="profile-info"><a class="nickname" href=" https://home.cnblogs.com/u/' + myprofile[0].blogName + '/">' +
		'</a>' +
		'<p id="mywords"></p>' +
		'</div>' +
		'</div>' +
		'<div class="myprofile-bottom">' +
		'<ul>' +
		'<li><a href="https://home.cnblogs.com/u/' + myprofile[0].blogName + '/" id="myyear">' +
		'</a>' +
		'</li>' +
		'<li><a href="https://home.cnblogs.com/u/' + myprofile[0].blogName + '/followers/" id="myfollower">' +
		'</a>' +
		'</li>' +
		'<li><a href="https://home.cnblogs.com/u/' + myprofile[0].blogName + '/followees/" id="myfollowee">' +
		'</a>' +
		'</li>' +
		'</ul>' +
		'</div>' +
		'<div class="myprofile-bottom">' +
		'<ul>' +
		'<li id="mypost">' +
		'</li>' +
		'<li id="myarticle">' +
		'</li>' +
		'<li id="mycomment">' +
		'</li>' +
		'</ul>' +
		'</div>' +
		'</div>';
	$('#blog-news').append(str);

	$("#profile_block a").each(function(idx) {
		if (idx == 1) {
			$('#myyear').html('园龄<br>' + $(this).context.innerText);
		}
		if (idx == 2) {
			$('#myfollower').html('粉丝<br>' + $(this).context.innerText);
		}
		if (idx == 3) {
			$('#myfollowee').html('关注<br>' + $(this).context.innerText);
		}
	});
	$('#profile_block').css('display', 'none');
	$('#mywords').html(myprofile[0].blogSign);
	$('#mypost').html($('#stats_post_count').text().replace(/\-/g, "<br>"));
	$('#myarticle').html($('#stats_article_count').text().replace(/\-/g, "<br>"));
	$('#mycomment').html($('#stats-comment_count').text().replace(/\-/g, "<br>"));
	$('.myprofile').append($('#p_b_follow'));
	$('.nickname').html($('#Header1_HeaderTitle').text());

}

// 设置博文底部个性签名
function setSignautre(myprofile) {
	var str = '<h2>作者信息</h2>'+
'<div id="card">'+
	'<div id="proBody">'+
		'<center>'+
			'<img src="'+ myprofile[0].blogAvatar + '">'+
			'<p class="name">'+  myprofile[0].blogName +'</p>'+
			'<p class="sign">'+ myprofile[0].blogSign+'</p>'+
			'<input type="button" class="contact" value="关注" onclick="'+ myprofile[0].blogFollow +';">'+
		'</center>'+
	'</div>'+
	'<div id="proFooter">'+
		'<ul>'+
		'	<li>'+
				'<a href="http://sighttp.qq.com/msgrd?v=1&amp;uin='+ myprofile[0].QQ+'" target="_blank">'+
					'<i class="fa fa-qq" style="font-size: 1.7rem"></i> &nbsp;&nbsp;&nbsp;&nbsp;Q&nbsp;Q'+
					'&nbsp;&nbsp;&nbsp;&nbsp;'+
				'</a>'+
			'</li>'+
			'<li>'+
				'<a href="'+ myprofile[0].Github+'" target="_blank">'+
					'<i class="fa fa-github fa-2x"></i>'+
					'Github'+
				'</a>'+
			'</li>'+
			'<li>'+
				'<a href="' + myprofile[0].WeChat + '" target="_blank">'+
					'<i class="fa fa-weixin fa-2x"></i>'+
					'WeChat'+
				'</a>'+
			'</li>'+
		'</ul>'+
	'</div>'+
'</div>';

	if ($('#cnblogs_post_body') != null) {
		$('#MySignature').append(str);
	}

}

function runCode(){
	$(function() {
		$('myscript').each(function() {
			$(this).css('display','none');
			eval($(this).text());
		});
	});
}