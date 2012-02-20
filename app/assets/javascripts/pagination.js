//i almost don't actually know what i'm doing here
var Pagination = jQuery.sub();
Pagination.fn.paginate = function (pageInfo, options) {
	//check the extremes
	var extremes = {
		min: 1,
		max: Math.ceil(pageInfo.total / pageInfo.count)
	};
	if (extremes.max === 1) {
		//there's no paging to display here
		return;
	}

	var perPage = pageInfo.count;
	
	//this is the page number.
	//page 1 should be start:0 and count:perPage
	var currentPage = Math.ceil((pageInfo.start + 1) / perPage);
	
	//make sure the currentPage is within boundaries
	currentPage = Math.max(currentPage, extremes.min);
	currentPage = Math.min(currentPage, extremes.max);
	
	var handleBarsData = {};
	
	//display the <previous> link if applicable
	if (!(currentPage === 1)) {
		handleBarsData.prevLocationIsThere = true;
		handleBarsData.prevStart = (currentPage-2) * perPage;
		handleBarsData.prevCount = perPage;
	}
	
	//display the numbered links
	handleBarsData.items = [];
	for (var x = 0; (x+1) <= extremes.max; x++) {
		handleBarsData.items.push({
			status: (x+1) === currentPage ? 'active': '',
			label: x+1,
			start: (x) * perPage,
			count: perPage
		});
	}
	
	//display the <next> link if applicable
	if (handleBarsData.items.length > 1 && (currentPage * perPage) < pageInfo.total) {
		handleBarsData.nextLocationIsThere = true;
		handleBarsData.nextStart = currentPage * perPage; //currentPage=1 with a perPage of the yield start=10 which is actually the start of page 2( -- page 1 was 0-9) 
		handleBarsData.nextCount = perPage;
	}
	
	//why are we using handlerbars again?
	var handlebarTemplate = Pagination(this).html();
	var template = Handlebars.compile(handlebarTemplate);
	Pagination(options.target).html(template(handleBarsData));
	//plant the handlers
	Pagination('.paginations > li > a').click(function () {
		var start = $(this).attr('data-page-start');
		var count = $(this).attr('data-page-count');
		options.handler(start, count);
		return false;
	});
	//page 1 of 3 &bull; 30 items
	Pagination(options.infoTarget).html("page "+ currentPage + ' of ' + extremes.max + ' &bull; ' + pageInfo.total +' ' + (options.itemLabel || 'items'));
	
};