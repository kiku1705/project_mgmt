$(document).ready(function() {
  $("#show-project-details").change(function() {
    var id = $("#show-project-details").val();
    if(!!id)
    {
      $.ajax({
        type: "GET",
        url: '/projects/'+ id + '/project_summary',
        xhr: function(){
          return new window.XMLHttpRequest();
        }
     });
    }
  });

  $("#chart-details").change(function() {
    var id = $("#chart-details").val();
    if(!!id)
    {
      $.ajax({
        type: "GET",
        url: '/projects/'+ id + '/chart_summary',
        }).done(function(results){
          var data = google.visualization.arrayToDataTable(
          results.task_data);
          var options = {title: 'Project Summary' };
          var chart = new google.visualization.PieChart(document.getElementById('projectChart'));
          chart.draw(data, options);
      });
    }
  });
});