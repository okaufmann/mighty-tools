{{ content()}}

<div class="col-sm-12">
    <h1>Sitemap Checker</h1>

    <form id="checkContext" action="check" method="POST" class="form-horizontal">
        <div class="form-group">
            <label for="sitemap-url" class="control-label col-sm-2 ">Sitemap URL</label>
            <div class="col-sm-6">
                <input type="url" required="true" name="sitemap_url" class="form-control" placeholder="http://yourewebsite.com/sitemap.xml">
            </div>
        </div>
        <div class="form-group">
            <div class="col-sm-offset-2 col-sm-10">
                <button type="submit" class="btn btn-primary">Check now</button>
            </div>
        </div>
    </form>

    <div class="well" id="resultWell">
        Results
    </div>
</div>

<script>
            var success = function(data) {
                $("#resultWell").html("");
                var errors = data.errors;
                var executionTime = data.executionTime;
                var entries = data.entries;
                var data = data["data"];

                $("#resultWell").append("<b>Execution Time (miliseconds):</b> " + executionTime + "<br/>");
                
                $("#resultWell").append("<b>Checked URLs:</b> " + entries + "<br/>");
                $("#resultWell").append("<b>Not found URLs:</b><br/><ul>");

                jQuery.each(errors, function(index, val) {
                    $("#resultWell").append("<li>" + val + "</li>");
                });
                
                $("#resultWell").append("</ul>");
            };

            $("#checkContext").submit(function(e) {
                e.preventDefault();

                $.ajax({
                    type: 'POST',
                    url: "{{ url("sitemapchecker/check") }}",
                    data: JSON.stringify($("#checkContext").serializeObject()),
                    success: success,
                    dataType: "json"
                });
            });

            $.fn.serializeObject = function()
            {
                var o = {};
                var a = this.serializeArray();
                $.each(a, function() {
                    if (o[this.name] !== undefined) {
                        if (!o[this.name].push) {
                            o[this.name] = [o[this.name]];
                        }
                        o[this.name].push(this.value || '');
                    } else {
                        o[this.name] = this.value || '';
                    }
                });
                return o;
            };
        </script>