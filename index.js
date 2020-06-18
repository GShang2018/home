new Vue({
	el: '#app',
	data: {
		search: [{
				favicon: 'https://ico.hnysnet.com/get.php?url=https://www.baidu.com/',
				name: '百度一下',
				info: '百度一下，你就知道',
				url: 'https://www.baidu.com/s?wd='
			},
			{
				favicon: 'https://ico.hnysnet.com/get.php?url=https://www.xiaoso.net/',
				name: '小搜索',
				info: '输入关键词',
				url: 'https://www.xiaoso.net/m/search?wd='
			},
			{
				favicon: 'https://ico.hnysnet.com/get.php?url=https://sci-hub.tw/',
				name: 'sci-hub',
				info: '输入DOI',
				url: 'https://sci-hub.tw/'
			},
			{
				favicon: 'https://ico.hnysnet.com/get.php?url=https://kns.cnki.net/',
				name: '中国知网',
				info: '输入文章主题',
				url: 'http://kns.cnki.net/kns/brief/Default_Result.aspx?code=SCDB&kw='
			}
		],
		series: [{
				series_name: '文献检索',
				series_content: [{
						favicon: 'https://ico.hnysnet.com/get.php?url=https://kns.cnki.net',
						url: 'https://kns.cnki.net/kns/brief/result.aspx?dbprefix=SCDB&crossDbcodes=CJFQ,CDFD,CMFD,CPFD,IPFD,CCND,CCJD',
						name: '中国知网',
						info: '中国最大的文献检索网站'
					},
					{
						favicon: 'https://ico.hnysnet.com/get.php?url=https://xueshu.baidu.com/',
						url: 'https://xueshu.baidu.com/',
						name: '百度学术',
						info: '保持学习的态度'
					},
					{
						favicon: 'https://ico.hnysnet.com/get.php?url=https://www.cn-ki.net/',
						url: 'https://www.cn-ki.net/',
						name: 'iData',
						info: '免费下载知网文献'
					},
					{
						favicon: 'https://ico.hnysnet.com/get.php?url=http://www.wanfangdata.com.cn/',
						url: 'http://www.wanfangdata.com.cn/searchResult/getAdvancedSearch.do?searchType=all',
						name: '万方数据库',
						info: '文献检索网站'
					},
					{
						favicon: 'https://ico.hnysnet.com/get.php?url=https://www.duxiu.com/',
						url: 'https://www.duxiu.com/?lsu=shr',
						name: '读秀',
						info: '专业查文献，书籍，支持文献互助'
					},
					{
						favicon: 'https://ico.hnysnet.com/get.php?url=https://www.chaoxing.com/',
						url: 'https://www.chaoxing.com/',
						name: '超星发现',
						info: '文献检索网站'
					},
					{
						favicon: 'https://ico.hnysnet.com/get.php?url=http://qikan.cqvip.com',
						url: 'http://qikan.cqvip.com/Qikan/Search/Advance?from=index',
						name: '维普资讯',
						info: '文献检索网站'
					},
					{
						favicon: 'https://ico.hnysnet.com/get.php?url=http://www.lib.ctgu.edu.cn/',
						url: 'http://210.42.38.36/reslist',
						name: '三大图书馆',
						info:'三峡大学校外访问'
					},
					{
						favicon: 'https://ico.hnysnet.com/get.php?url=http://xilesou.99lb.net/',
						url: 'http://xilesou.99lb.net/',
						name: 'Glgoo',
						info:'谷歌学术镜像网站'
					},
					{
						favicon: 'https://ico.hnysnet.com/get.php?url=https://www.ixueshu.com/',
						url: 'https://www.ixueshu.com/',
						name: '爱学术',
						info:'关注公众号，下载文献'
					},
					{
						favicon: 'https://ico.hnysnet.com/get.php?url=https://arxiv.org/',
						url: 'https://arxiv.org/',
						name: 'Arxiv',
						info:'收集物理学、数学、计算机科学与生物学论文预印本的网站'
					},
					{
						favicon: 'https://ico.hnysnet.com/get.php?url=https://scholar.chongbuluo.com/',
						url: 'https://scholar.chongbuluo.com/',
						name: '学术搜索',
						info:'虫部落学术搜索资源整合'
					},
				]
			},
			{
				series_name: '代码社区',
				series_content: [
					{
						favicon: 'https://ico.hnysnet.com/get.php?url=https://www.csdn.net/',
						url: 'https://www.csdn.net/',
						name: 'CSDN',
						info:'程序员最活跃的社区'
					},
					{
						favicon: 'https://ico.hnysnet.com/get.php?url=https://www.cnblogs.com/',
						url: 'https://www.cnblogs.com/',
						name: '博客园',
						info:'小众的博客社区'
					},
					{
						favicon: 'https://ico.hnysnet.com/get.php?url=https://github.com/',
						url: 'https://github.com/',
						name: 'Github',
						info:'全球最大的开源社区'
					},
					{
						favicon: 'https://ico.hnysnet.com/get.php?url=https://gitee.com/',
						url: 'https://gitee.com/',
						name: 'Gitee',
						info:'中国的Github'
					},
					{
						favicon: 'https://ico.hnysnet.com/get.php?url=https://www.ilovematlab.cn/forum.php?mod=home',
						url: 'https://www.ilovematlab.cn/forum.php?mod=home',
						name: 'Matlab',
						info:'Matlab中文论坛'
					},
					{
						favicon: 'https://ico.hnysnet.com/get.php?url=http://www.pudn.com/',
						url: 'http://www.pudn.com/',
						name: '联合开发网',
						info:'代码资源挺多的'
					},
					{
						favicon: 'https://ico.hnysnet.com/get.php?url=http://www.verysource.com/',
						url: 'http://www.verysource.com/',
						name: 'VerySource',
						info:'代码资源网站'
					},
					{
						favicon: 'https://ico.hnysnet.com/get.php?url=http://www.codeforge.cn/',
						url: 'http://www.codeforge.cn/',
						name: 'Codeforge',
						info:'代码资源网站'
					},
				]
			}
		]
	}
})

var search_engine = 'https://www.baidu.com/s?wd=';

$('#search-logo').click(function() {
	$('#search-list').slideToggle()
})

$('#search-btn').click(function() {
	window.open(search_engine + $('#search-input').val());
})

$('#search-input').bind('keypress', function(event) {
	if (event.keyCode == "13") {
		window.open(search_engine + $('#search-input').val());
	}
});

$('#search-input').click(function() {
	$(this).attr('placeholder', '')
})
$('.search-engine').click(function() {
	search_engine = $(this).attr('data-url');
	$('#search-input').attr('placeholder', $(this).attr('data-info'))
	$('#search-logo img').attr('src', $(this).children('img').attr('src'));
	$('#search-list').slideToggle()
})
$('.sidebar-toggle').click(function() {
	$('#sidebar').toggleClass('sidebar-close')
})
