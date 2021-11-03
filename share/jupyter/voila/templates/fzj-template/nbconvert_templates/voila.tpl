{%- extends 'base.tpl' -%}
{% from 'mathjax.tpl' import mathjax %}

{# this overrides the default behavior of directly starting the kernel and executing the notebook #}
{% block notebook_execute %}
{% endblock notebook_execute %}

{%- block html_head_css -%}
<link href="{{resources.base_url}}voila/static/index.css" rel="stylesheet" type='text/css'>
{% if resources.theme == 'dark' %}
{% set bar_color = '#555454' %}
<link href="{{resources.base_url}}voila/static/theme-dark.css" rel="stylesheet" type='text/css'>
{% else %}
{% set bar_color = '#5cbcaf' %}
<link href="{{resources.base_url}}voila/static/theme-light.css" rel="stylesheet" type='text/css'>
{% endif %}
<link href="{{resources.base_url}}voila/static/materialize.min.css" rel="stylesheet" type='text/css'>

{% for inline_css in resources.inlining.css %}
<style type="text/css">
{{ inline_css }}
</style>
{% endfor %}

<style type="text/css">
  html, body {
      height: 100%;
  }

  body {
    background-color: #023d6b;
    overflow-y: scroll;
    font-family: arial;
  }

  .nav-wrapper {
    background-color:#ffffff;
    color:#023d6b;
  }

  nav .brand-logo {
      color:#023d6b;
      align-items: center;
    height: 90%;
  }


  body nav ul h1 {
      color:#023d6b;
  }

  body nav a {
      color:#023d6b;
  }

  #loading {
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      height: 75vh;
      color: #ffffff;
      font-family: sans-serif;
  }

  .spinner {
    animation: rotation 2s infinite linear;
    transform-origin: 50% 50%;
  }

  .spinner-container {
    width: 10%;
  }

  @keyframes rotation {
    from {transform: rotate(0deg);}
    to   {transform: rotate(359deg);}
  }

  .voila-spinner-color1{
    fill: #ffffff;
  }

  .voila-spinner-color2{
    fill: #b9d25f;
  }

  @font-face {
    font-family: 'Material Icons';
    font-style: normal;
    font-weight: 400;
    src: url({{resources.base_url}}voila/static/icons_font.ttf) format('truetype');
  }

  .p-Widget.jupyter-button.mod-success {
    background-color: #b9d25f;
  }

  .material-icons {
    font-family: 'Material Icons';
    font-weight: normal;
    font-style: normal;
    font-size: 24px;
    line-height: 1;
    letter-spacing: normal;
    text-transform: none;
    display: inline-block;
    white-space: nowrap;
    word-wrap: normal;
    direction: ltr;
    color: #023d6b;
  }

  button:focus{
    background-color: #b9d25f;
  }

  .right {
    float: right;
    /*width: 25%;*/
    padding: 10px;
    /*margin-right: 30px;*/
  }

  .left{
    margin-left: 30px;
    float: left;
    width: 40%;
    padding: 10px;
  }

  .middle {
    float: left;
    width: 25%;
    padding: 10px;
  }

  .wrapper {
    min-height: 100%;
    margin-bottom: -119px;
    padding-bottom: 129px;
  }


  	input:disabled {
	  color: black !important;
	  font-weight: bold;
	}
</style>


<style>
a.anchor-link {
  display: none;
}
.highlight  {
  margin: 0.4em;
}
</style>

{{ mathjax() }}
{%- endblock html_head_css -%}

{%- block body -%}
{%- block body_header -%}
{% set nb_title = nb.metadata.get('title', '') or resources['metadata']['name'] %}

<body data-base-url="{{resources.base_url}}voila/">
  <div id="loading">
    <div class="spinner-container">
      <svg class="spinner" data-name="c1" version="1.1" viewBox="0 0 500 500" xmlns="http://www.w3.org/2000/svg" xmlns:cc="http://creativecommons.org/ns#" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"><metadata><rdf:RDF><cc:Work rdf:about=""><dc:format>image/svg+xml</dc:format><dc:type rdf:resource="http://purl.org/dc/dcmitype/StillImage"/><dc:title>voila</dc:title></cc:Work></rdf:RDF></metadata><title>spin</title><path class="voila-spinner-color1" d="m250 405c-85.47 0-155-69.53-155-155s69.53-155 155-155 155 69.53 155 155-69.53 155-155 155zm0-275.5a120.5 120.5 0 1 0 120.5 120.5 120.6 120.6 0 0 0-120.5-120.5z"/><path class="voila-spinner-color2" d="m250 405c-85.47 0-155-69.53-155-155a17.26 17.26 0 1 1 34.51 0 120.6 120.6 0 0 0 120.5 120.5 17.26 17.26 0 1 1 0 34.51z"/></svg>
    </div>
    <h5 id="loading_text">Running {{nb_title}}...</h5>
  </div>
<script>
var voila_process = function(cell_index, cell_count) {
  var el = document.getElementById("loading_text")
  el.innerHTML = `Executing ${cell_index} of ${cell_count}`
}
</script>

<div id="rendered_cells" style="display: none">
{%- endblock body_header -%}

{% set nb_title = nb.metadata.get('title', '') or resources['metadata']['name'] %}
  <div class="wrapper">
    <header>
      <div class="navbar-fixed" style="height: 120px; z-index: 9999;">
        <nav class="top-nav" style="line-height: 120px; height: 120px;">
          <div class="nav-wrapper">
            <a href="#!" class="brand-logo center" style="font-weight: bold; text-transform: uppercase;">{{nb_title}}</a>
            <a href="https://www.fz-juelich.de/iek/iek-3/EN/Home/home_node.html" class="brand-logo right" target="_blank">
              <img class="brand-logo right" src="https://upload.wikimedia.org/wikipedia/commons/4/40/Logo_des_Forschungszentrums_J%C3%BClich_seit_2018.svg" style="margin-top: 30px; height: 50%; margin-right: 20px;"></img>
            </a>
            <ul class="brand-logo left" style="margin-top: 30px;">
              <li><a href="#"><i class="material-icons" id="kernel-status-icon">radio_button_unchecked</i></a></li>
            </ul>
          </div>
        </nav>
      </div>
    </header>

    <main>
      <div class="container">
        <div class="row" style="margin-bottom: -10px;">
          <div class="col s12">
            {% if resources.theme == 'dark' %}
            <div class="jp-Notebook theme-dark">
            {% else %}
            <div class="jp-Notebook theme-light">
            {% endif %}
              {%- block body_loop -%}
                {# from this point on, the kernel is started #}
                {%- with kernel_id = kernel_start() -%}
                  <script id="jupyter-config-data" type="application/json">
                  {
                      "baseUrl": "{{resources.base_url}}",
                      "kernelId": "{{kernel_id}}"
                  }
                  </script>
                  {% set cell_count = nb.cells|length %}
                  {%- for cell in cell_generator(nb, kernel_id) -%}
                    {% set cellloop = loop %}
                    {%- block any_cell scoped -%}
                    <script>
                      voila_process({{ cellloop.index }}, {{ cell_count }})
                    </script>
                      {{ super() }}
                    {%- endblock any_cell -%}
                  {%- endfor -%}
                {% endwith %}
              {%- endblock body_loop -%}
              <div id="rendered_cells" style="display: none">
            </div>
          </div>
        </div>
      </div>
     <div class="push"></div> 
    </main>
  </div>
  


{%- block body_footer -%}

  <!-- Site footer -->
<footer class="site-footer" style="z-index: 9999; background-color: white; bottom: 0%; width: 100%;height: 129px;">
  <hr style="margin-top: 0px;">
  <div class="row" style="margin-bottom: 0px;">
    <div class="left">
      <a target="_blank" href="https://fz-juelich.de/iek/iek-3/EN/Home/home_node.html" style="color: #023d6b; font-weight: bold;">© 2021 Forschungszentrum Jülich GmbH</a>
    </div>
        
    <div class="middle">
      <a target="_blank" href="http://www.metis-platform.net/metis-platform/EN/_ServicePages/Imprint/_node.html;jsessionid=FFAF99E7AD5DD644EC762EC0096E1C6E" style="color: #023d6b; font-weight: bold;">IMPRINT</a>&nbsp;&nbsp; 
        <a target="_blank" href="http://www.metis-platform.net/metis-platform/EN/_ServicePages/DataProtection/_node.html;jsessionid=FFAF99E7AD5DD644EC762EC0096E1C6E" style="color: #023d6b; font-weight: bold;">DATA PROTECTION</a>
    </div>
        
    <div class="right">
      <img style="float: right;" width=100px src="http://www.metis-platform.net/SiteGlobals/StyleBundles/Bilder/NeuesLayout/metis-platform/logo_bmwi.jpg;jsessionid=9B4BFB0C1F70114502022FFE13AF5A6E?__blob=normal">
      <a style="float: right;padding-right: 10px; padding-top: 20px;" href="http://www.metis-platform.net/">
        <img width=100px  src="https://www.wiwi.rwth-aachen.de/global/show_picture.asp?id=aaaaaaaaabczicn&w=842&q=77&meta=0" alt="Metis Logo">
      </a> 
      
    </div>
  </div>
</footer>

<script type="text/javascript">
    (function() {
      // remove the loading element
      var el = document.getElementById("loading")
      el.parentNode.removeChild(el)
      // show the cell output
      el = document.getElementById("rendered_cells")
      el.style.display = 'unset'
    })();
  </script>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script src="{{resources.base_url}}voila/static/materialize.min.js"></script>


</body>
{%- endblock body_footer -%}

{% block footer_js %}
  {{ super() }}
  <script type="text/javascript">
    requirejs(['static/voila'], function(voila) {
      (async function() {
        var kernel = await voila.connectKernel();

        kernel.statusChanged.connect(() => {
          // console.log(kernel.status);
          var el = document.getElementById("kernel-status-icon");
          
          if (kernel.status == 'busy') {
            el.innerHTML = 'radio_button_checked';
          } else {
            el.innerHTML = 'radio_button_unchecked';
          }
          // ugly workaround to show select
          $('select').attr("class", "browser-default");

        });
      })();
    });
  </script>
  
{% endblock footer_js %}

{%- endblock body -%}
