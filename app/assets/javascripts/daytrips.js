function system_rides(filePath) {
  var margin = {top: 0, right: 0, bottom: 50, left: 45},
      width = 700 - margin.left - margin.right,
      height = 300 - margin.top - margin.bottom;

  var parseDate = d3.time.format("%Y-%m-%d").parse;

  var x = d3.time.scale().range([0, width]),
      y = d3.scale.linear().range([height, 0]),
      ybar = d3.scale.linear().range([height, 0]).domain([0,1]);

  var xAxis = d3.svg.axis().scale(x).orient("bottom"),
      yAxis = d3.svg.axis().scale(y).orient("left");

  var color = d3.scale.ordinal()
      .range([colorUsers.total, colorUsers.subscriber, colorUsers.customer]),
      bars = d3.scale.ordinal();

  var line = d3.svg.line()
      .interpolate("monotone") // linear, step, step-before, step-after, basis, basis-open, cardinal, cardinal-open, monotone
      .x(function(d) { return x(d.date); })
      .y(function(d) { return y(d.rides); });

  var baritup = d3.svg.area()
      .interpolate("step")
      .x(function(d) { return x(d.date); })
      .y0(height)
      .y1(function(d) { return ybar(d.bool); });

  var svg = d3.select("#row2").append("svg")
      .attr("width", width + margin.left + margin.right)
      .attr("height", height + margin.top + margin.bottom);

  var chart = svg.append("g")
      .attr("class", "chart")
      .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

  var title = chart.append("text")
      .text("System-wide Rides per Day")
      .attr("class", "title")
      .style("text-anchor", "middle")
      .attr("x", width/2)
      .attr("y", height+margin.bottom-5);

  d3.json(filePath, function(error, data) {
    color.domain(d3.keys(data[0]).filter(function(key) { return (key == "rides" ); }));
    bars.domain(d3.keys(data[0]).filter(function(key) { return (key == "weekend" ) ; }));

    data.forEach(function(d) {
      d.date = parseDate(d.date);
      d.rides = +d.rides;
    });
    
    var userType = color.domain().map(function(name) {
      return {
        name: name,
        values: data.map(function(d) {
          return {date: d.date, rides: +d[name]};
        })
      };
    });

    var specialDay = bars.domain().map(function(name) {
      return {
        name: name,
        values: data.map(function(d) {
          return {date: d.date, bool: +d[name]};
        })
      };
    });

    x.domain(d3.extent(data, function(d) { return d.date; }));
    y.domain([
        d3.min(userType, function(c) { return d3.min(c.values, function(v) { return v.rides; }); }),
        d3.max(userType, function(c) { return d3.max(c.values, function(v) { return v.rides; }); })
    ]);

    var chartUsers = chart.selectAll(".chartUsers")
        .data(userType)
      .enter().append("g")
        .attr("class", "chartUsers");

    var weekend = chart.selectAll(".weekend")
        .data(specialDay)
      .enter().append("g");

    chartUsers.append("path")
        .attr("class", "line")
        .attr("d", function(d) { return line(d.values); })
        .style("stroke", function(d) { return color(d.name); })
        .style("stroke-width", "2px");

    weekend.append("path")
        .attr("class", function(d){ return "bars weekendline"; })
        .attr("d", function(d) { return baritup(d.values); })
        .style("display","none");

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
        .text("rides");
  });
} //end system_rides()

system_rides('daytrips.json')

$(document).on('click', '#weekendcheck', function () {
     $('#weekendcheck').is(':checked') ? $('.weekendline').toggle(true) : $('.weekendline').toggle(false);
 });
