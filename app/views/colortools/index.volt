{{ content()}}
<h1>Welcome to Mighty Tools!</h1>

{{ form("colortools")}}

<textarea class="form-control" style="width:80%" rows="8" name="fieldColors">{{fieldColors}}</textarea>
<br>
<button class="btn btn-primary" type="submit">Do it</button>
</form>

{%  if colors is not null %}
    <table class="table">
        <thead>
            <tr>
                <th>Code</th>
                <th>Color</th>
            </tr>
        </thead>
        <tbody>
            {% for color in colors %}
                <tr>
                    <td><b>{{color}}</b></td>
                    <td><div class="colorSample" style="background-color:{{color}}"></div></td>
                </tr>
            {% endfor %}
        </tbody>
    </table>
{% endif %}