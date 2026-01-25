var container = document.getElementById('container'),
    rvContainer = document.getElementById('roadview'),
    mapContainer = document.getElementById('map');

var geocoder = new kakao.maps.services.Geocoder();
geocoder.addressSearch(targetAddress, function(result, status) {

    if (status === kakao.maps.services.Status.OK) {

        var placePosition = new kakao.maps.LatLng(result[0].y, result[0].x);

        var mapOption = {
            center: placePosition,
            level: 3
        };
        var map = new kakao.maps.Map(mapContainer, mapOption);

        var mapMarker = new kakao.maps.Marker({
            position: placePosition,
            map: map
        });

        var roadview = new kakao.maps.Roadview(rvContainer);
        var roadviewClient = new kakao.maps.RoadviewClient();

        roadviewClient.getNearestPanoId(placePosition, 50, function(panoId) {
            if (panoId) {
                roadview.setPanoId(panoId, placePosition);
            } else {
                alert("해당 위치는 로드뷰를 지원하지 않습니다.");
            }
        });

        kakao.maps.event.addListener(roadview, 'init', function() {
            var rvMarker = new kakao.maps.Marker({
                position: placePosition,
                map: roadview
            });
        });

        window.toggleMap = function(active) {
            if (active) {
                container.className = "view_map";
            } else {
                container.className = "view_roadview";
                roadview.relayout();
            }
        };
    }
});