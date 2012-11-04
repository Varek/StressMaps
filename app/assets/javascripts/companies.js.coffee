
nokia.Settings.set( "appId", "f6lLDfC-aV6fLampW7BD")
nokia.Settings.set( "authenticationToken", "OWdxU9eV-PTTgzXLRwaLjg")
map = undefined
heatmapProvider = undefined
markersContainer = undefined
$ ->
  company = $('#company')
  company_area_marker_0 = new nokia.maps.geo.Coordinate(company.data('area-0-lat'),company.data('area-0-lon'))
  company_area_marker_1 = new nokia.maps.geo.Coordinate(company.data('area-1-lat'), company.data('area-1-lon'))
  company_area_bbox = new nokia.maps.geo.BoundingBox(company_area_marker_0, company_area_marker_1)
  mapContainer = document.getElementById("mapContainer")#$("#mapContainer")
  map = new nokia.maps.map.Display(mapContainer, {
        # Zoom level for the map
        'zoomLevel': 10,
        # Map center coordinates
        'center': [52.51, 13.4],
        'baseMapType': nokia.maps.map.Display.SATELLITE,
        'components': [
            # ZoomBar provides a UI to zoom the map in & out
            new nokia.maps.map.component.ZoomBar(),
            # We add the behavior component to allow panning / zooming of the map
            new nokia.maps.map.component.Behavior(),
            new nokia.maps.map.component.ScaleBar(),
            # Positioning will show a set "map to my GPS position" UI button
            # * Note: this component will only be visible if W3C geolocation API
            # * is supported by the browser and if you agree to share your location.
            # * If you location can not be found the positioning button will reset
            # * itself to its initial state
            # */
            new nokia.maps.positioning.component.Positioning(),
            # Add ContextMenu component so we get context menu on right mouse click / long press tap
            new nokia.maps.map.component.ContextMenu()
        ]
    })

  map.zoomTo(company_area_bbox)
  area_marker_container = new nokia.maps.map.Container()
  markersContainer = new nokia.maps.map.Container()
  map.objects.add(area_marker_container)
  map.objects.add(markersContainer)
  area_marker_0 = new nokia.maps.map.StandardMarker(company_area_marker_0)
  area_marker_1 = new nokia.maps.map.StandardMarker(company_area_marker_1)
  #area_marker_container.objects.addAll([area_marker_0, area_marker_1])
  drawHeatMap(map,[],undefined)
  time_travel(map)

drawHeatMap = (map,employees,timestamp) ->
  map.overlays.clear()
  markersContainer.objects.clear()
  currentTime = $('#current_time').val()
  filterDepartment = $('#filter_department :selected').text()
  rawBioSignals = $('.bio_signal').filter( ->
    time = parseInt($(this).data("created-at")) == parseInt(currentTime)
    #if filterDepartment
    #  department = $(this).data("department") == filterDepartment
    #else
    #  department = true
    #time && department
    time)
  bioSignals = (createBioSignalData(bioSignal,markersContainer) for bioSignal in rawBioSignals)
  #heatMapDataSet = bioSignals#[{latitude: 37.483542, longitude: -122.148977, value: 5.3},{latitude: 37.484542, longitude: -122.149977, value: 12.3},{latitude: 37.483542, longitude: -122.149977, value: 3.3}]#locationsToHeatMapData(movement[timestamp]);
  heatmapProvider = new nokia.maps.heatmap.Overlay({
    max: 20,
    opacity: 0.6,
    type: "value",
    coarseness: 2})

  heatmapProvider.addData(bioSignals)
  map.overlays.add(heatmapProvider)
  #$('#photoContainer').append('<a href="#foo" class="time_travel" data-timestamp="' + (timestamp-600) +'"><div class="arrow_up"></div></a>')
  #$('#photoContainer').append('<a href="#baz" class="time_travel" data-timestamp="' + (timestamp+600) +'"><div class="arrow_down"></div></a>')
  # for (var i = 0; i < movement[timestamp].length; i++) {
  #   if (!movement[timestamp][i]['latitude'] || !movement[timestamp][i]['longitude']) continue
  #   var coord = new nokia.maps.geo.Coordinate(parseFloat(movement[timestamp][i]['latitude']),parseFloat(movement[timestamp][i]['longitude']))
  #   markersContainer.objects.add(new nokia.maps.map.StandardMarker(coord))
  #   var thumbUrl = movement[timestamp][i]['thumbUrl'].replace('/h/','/w/')
  #   $('#photoContainer').append('<div class="photo_div"><img src="'+thumbUrl+'"></div>')
  # }

createBioSignalData = (rawBioSignal) ->
 location = $(rawBioSignal).data('location')
 stress = $(rawBioSignal).data('stress-level')
 databs = {latitude: location[0], longitude: location[1], value: stress}
 markersContainer.objects.add(new nokia.maps.map.StandardMarker(databs)) if stress > 9.0
 return databs

time_travel = (map) ->
  $('.time_travel').click( ->
    currentTime = $('#current_time').val()
    if $(this).attr('id','next')
      $('#current_time').val(currentTime+600)
    else
      $('#current_time').val(currentTime-600)
    drawHeatMap(map,[],undefined))
