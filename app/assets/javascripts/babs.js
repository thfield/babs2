var babs = babs || {};
babs.chart = {};
babs.defaults = {};
babs.util = {};

babs.defaults.colorSwatches = [ "#7bccc4", "#0070cd", "#bae4bc" ];

babs.util.chooseCity = function(event){
  // var city = /city\-(\w{2,3})/.exec(this.id)[1];
  var city = this.dataset.city
  var page = event.data.page;
  $( "#control-city div button" ).removeClass( "active");
  $(this).addClass("active");

  if( page == "trips"){
    $('#chart').empty();
    babs.chart.line_series_zoom({
      city: city,
      filePath: "daytrip_"+ city +".csv"
    });
  };
  // console.log(city);
  // console.log(page);
};

babs.util.expandCity = function(abbrev){
  switch(abbrev){
    case "all":
        return "System-wide";
        break;
    case "sj":
        return "San Jose";
        break;
    case "rc":
        return "Redwood City";
        break;
    case "mv":
        return "Mountain View";
        break;
    case "pa":
        return "Palo Alto"
        break;
    case "sf":
        return "San Francisco"
        break;
    default:
        break;
  }
}

babs.chart.line_series = function(opt){
  // var margin = (opt.margin || babs.defaults.margin),
  var margin = { top: 0, right: 0, bottom: 50, left: 45 },
      width = (opt.width || 700) - margin.left - margin.right,
      height = (opt.height || 300) - margin.top - margin.bottom;

  var parseDate = d3.time.format(opt.dateParse).parse;

  var x = d3.time.scale().range([0, width]),
      y = d3.scale.linear().range([height, 0]),
      ybar = d3.scale.linear().range([height, 0]).domain([0,1]);``

  var xAxis = d3.svg.axis().scale(x).orient("bottom"),
      yAxis = d3.svg.axis().scale(y).orient("left");

  var series = d3.scale.ordinal()
      .range( opt.colorSwatches || babs.defaults.colorSwatches ),
      bars = d3.scale.ordinal();

  var line = d3.svg.line()
      .interpolate("monotone")
      .x(function(d) { return x(d.xVar); })
      .y(function(d) { return y(d.yVar); });

  var svg = d3.select(opt.pageTarget).append("svg")
      .attr("width", width + margin.left + margin.right)
      .attr("height", height + margin.top + margin.bottom);

  var chart = svg.append("g")
      .attr("class", "chart")
      .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

  var title = chart.append("text")
      .text(opt.title)
      .attr("class", "title")
      .style("text-anchor", "middle")
      .attr("x", width/2)
      .attr("y", height+margin.bottom-5);

  d3.json(opt.filePath, function(error, data) {
  // d3.csv(opt.filePath, function(error, data) {
    series.domain(d3.keys(data[0]).filter(function(key) { return (key !== opt.indVar ); }));

    if (opt.dateParse) {
      data.forEach(function(d) {
        d[opt.indVar] = parseDate(d[opt.indVar]);
      });
    };

    var seriesNum = series.domain().map(function(name) {
      return {
        name: name,
        values: data.map(function(d) {
          return { xVar: d[opt.indVar], yVar: +d[name] };
        })
      };
    });

    x.domain(d3.extent(data, function(d) { return d[opt.indVar]; }));
    y.domain([
        d3.min(seriesNum, function(c) { return d3.min(c.values, function(v) { return v.yVar; }); }),
        d3.max(seriesNum, function(c) { return d3.max(c.values, function(v) { return v.yVar; }); })
    ]);

    var chartSeries = chart.selectAll(".chartSeries")
        .data(seriesNum)
      .enter().append("g")
        .attr("class", "chartSeries");

    chartSeries.append("path")
        .attr("class", "line")
        .attr("d", function(d) { return line(d.values); })
        .style("stroke", function(d) { return series(d.name); })
        .style("stroke-width", "2px");

    chart.append("g")
        .attr("class", "x axis")
        .attr("transform", "translate(0," + height + ")")
        .call(xAxis);

    chart.append("g")
        .attr("class", "y axis")
        .call(yAxis)
      .append("text")
        .attr("transform", "rotate(-90)")
        .attr("y", 6)
        .attr("dy", ".71em")
        .style("text-anchor", "end")
        .text(opt.yAxisTitle);
  });
};


babs.chart.line_series_zoom = function(opt){
  opt.pageTarget = opt.pageTarget || '#chart';
  opt.indVar = opt.indVar || 'date';
  opt.dateParse = opt.dateParse || '%Y-%m-%d';
  opt.yAxisTitle = opt.yAxisTitle || 'rides';

  var margin = {top: 10, right: 40, bottom: 100, left: 40},
      margin2 = {top: 430, right: 40, bottom: 20, left: 40},
      width = 800 - margin.left - margin.right,
      height = 500 - margin.top - margin.bottom,
      height2 = 500 - margin2.top - margin2.bottom;

  var parseDate = d3.time.format(opt.dateParse).parse;

  var x = d3.time.scale().range([0, width]),
      x2 = d3.time.scale().range([0, width]),
      y = d3.scale.linear().range([height, 0]),
      y2 = d3.scale.linear().range([height2, 0]);

  var xAxis = d3.svg.axis().scale(x).orient("bottom"),
      xAxis2 = d3.svg.axis().scale(x2).orient("bottom"),
      yAxis = d3.svg.axis().scale(y).orient("left");

  var brush = d3.svg.brush()
      .x(x2)
      .on("brush", brushed);

  var series = d3.scale.ordinal()
        .range(opt.colorSwatches || babs.defaults.colorSwatches);

  var line = d3.svg.line()
      .interpolate("monotone")
      .x(function(d) { return x(d.xVar); })
      .y(function(d) { return y(d.yVar); });

  var line2 = d3.svg.line()
      .interpolate("monotone")
      .x(function(d) { return x2(d.xVar); })
      .y(function(d) { return y2(d.yVar); });

  var svg = d3.select(opt.pageTarget).append("svg")
      .attr("width", width + margin.left + margin.right)
      .attr("height", height + margin.top + margin.bottom);

  svg.append("defs").append("clipPath")
      .attr("id", "clip")
    .append("rect")
      .attr("width", width)
      .attr("height", height);

  var focus = svg.append("g")
      .attr("class", "focus")
      .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

  var context = svg.append("g")
      .attr("class", "context")
      .attr("transform", "translate(" + margin2.left + "," + margin2.top + ")");

  d3.csv(opt.filePath, function(error, data) {

    // series.domain(d3.keys(data[0]).filter(function(key) { return (key !== opt.indVar ); }));
    series.domain(d3.keys(data[0]).filter(function(key) { return (key !== opt.indVar ); }));

    if (opt.dateParse) {
      data.forEach(function(d) {
        d[opt.indVar] = parseDate(d[opt.indVar]);
      });
    };

    var seriesNum = series.domain().map(function(name) {
      return {
        name: name,
        values: data.map(function(d) {
          return {xVar: d[opt.indVar], yVar: +d[name]};
        })
      };
    });


    x.domain(d3.extent(data, function(d) { return d[opt.indVar]; }));
    y.domain([
      d3.min(seriesNum, function(c) { return d3.min(c.values, function(v) { return v.yVar; }); }),
      d3.max(seriesNum, function(c) { return d3.max(c.values, function(v) { return v.yVar; }); })
    ]);
    x2.domain(x.domain());
    y2.domain(y.domain());

    focus.append("g")
        .attr("class", "x axis")
        .attr("transform", "translate(0," + height + ")")
        .call(xAxis);

    focus.append("g")
        .attr("class", "y axis")
        .call(yAxis)
      .append("text")
        .attr("transform", "rotate(-90)")
        .attr("y", 6)
        .attr("dy", ".71em")
        .style("text-anchor", "end")
        .text("rides");

    context.append("g")
        .attr("class", "x axis")
        .attr("transform", "translate(0," + height2 + ")")
        .call(xAxis2);

    var focusSeries = focus.selectAll(".focusSeries")
        .data(seriesNum)
      .enter().append("g")
        .attr("class", "focusSeries");

    var contextSeries = context.selectAll(".contextSeries")
        .data(seriesNum)
      .enter().append("g")
        .attr("class", "contextSeries");

    contextSeries.append("path")
        .attr("class", "line")
        .attr("d", function(d) { return line2(d.values); })
        .style("stroke", function(d) { return series(d.name); })
        .style("stroke-width", "2px");

    focusSeries.append("path")
        .attr("class", "line")
        .attr("d", function(d) { return line(d.values); })
        .style("stroke", function(d) { return series(d.name); })
        .style("stroke-width", "2px");

    focusSeries.append("text")
        .attr("transform", function(d, i) { return "translate(0," + i * 20 + ")"; })
        .attr("x", width - 26)
        .attr("dy", 10)
        .style("text-anchor", "end")
        .text(function(d) { return d.name; });

    focusSeries.append("rect")
        .attr("transform", function(d, i) { return "translate(0," + i * 20 + ")"; })
        .attr("x", width - 20)
        .attr("width", 18)
        .attr("height", 18)
        .style("fill", function(d) { return series(d.name); });

    context.append("g")
        .attr("class", "x brush")
        .call(brush)
      .selectAll("rect")
        .attr("y", -6)
        .attr("height", height2 + 7);


    var chartTitle = (d3.select('#chart-title') || d3.select(opt.pageTarget).insert("h1", ":first-child").attr('id', 'chart-title'));

    chartTitle.text( babs.util.expandCity(opt.city) + ' Trips per Day' );

    });

  function brushed() {
    x.domain(brush.empty() ? x2.domain() : brush.extent());
    focus.selectAll(".line").attr("d", function(d) { return line(d.values); });
    focus.select(".x.axis").call(xAxis);
  }
}
