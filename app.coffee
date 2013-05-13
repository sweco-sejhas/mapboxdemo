$ ->
  osm = new OpenLayers.Layer.XYZ 'mapbox', [
    "http://a.tiles.mapbox.com/v3/bjornharrtell.map-em5abk65/${z}/${x}/${y}.png"
    "http://b.tiles.mapbox.com/v3/bjornharrtell.map-em5abk65/${z}/${x}/${y}.png"
    "http://c.tiles.mapbox.com/v3/bjornharrtell.map-em5abk65/${z}/${x}/${y}.png"
    "http://d.tiles.mapbox.com/v3/bjornharrtell.map-em5abk65/${z}/${x}/${y}.png"]
   ,
    attribution: "&copy; <a href='http://www.openstreetmap.org/copyright'>OpenStreetMap</a> contributors"
    sphericalMercator: true
    wrapDateLine: true

  map = new OpenLayers.Map
    div: 'map'
    layers: [osm]
    center: [1721973.373208, 9047015.384574]
    zoom: 5
    controls: [new OpenLayers.Control.Navigation, new OpenLayers.Control.Attribution]

  markers = new OpenLayers.Layer.Vector 'markers',
    styleMap: new OpenLayers.StyleMap
      default:
        strokeWidth: 0.5
        pointRadius: 4
        fillColor: '#ff0000'
  
  map.addLayer markers
  
  selectFeature = new OpenLayers.Control.SelectFeature markers
  map.addControl selectFeature
  selectFeature.activate()
  
  selectedFeature = null
  
  markers.events.register 'featureselected', null, (e) ->
    $('.panel').fadeIn()
    selectedFeature = e.feature
    $('#v1').prop 'checked', selectedFeature.attributes.v1
    $('#v2').prop 'checked', selectedFeature.attributes.v2
    $('#v3').prop 'checked', selectedFeature.attributes.v3
    $('#errortitle').text('Felanmälan ' + selectedFeature.fid)

  $('#draw').button(
    icons: { primary: "ui-icon-pencil" }
    disabled: true
  ).click ->
    $('.panel').fadeIn()
  $('#draw').attr 'disabled', 'disabled'
  
  $('#login').button()
    .click ->
      $('#login').fadeOut()
      $('#draw').fadeIn()
      attr =
        v1: false
        v2: false
        v3: false
      markers.addFeatures [
        new OpenLayers.Feature.Vector (new OpenLayers.Geometry.Point 1650000, 8500000), attr
        new OpenLayers.Feature.Vector (new OpenLayers.Geometry.Point 1850000, 9500000), attr
        new OpenLayers.Feature.Vector (new OpenLayers.Geometry.Point 1450000, 8000000), attr
      ]
      markers.features[0].fid = 1
      markers.features[1].fid = 2
      markers.features[2].fid = 3
  
  $('input[type=checkbox]').click (e) ->
    selectedFeature?.attributes[this.id] = $(this).prop 'checked'


