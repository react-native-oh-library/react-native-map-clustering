/*
 * Copyright (c) 2025 Huawei Device Co., Ltd. All rights reserved
 * Use of this source code is governed by a MIT license that can be
 * found in the LICENSE file.
 */

import React from "react";
import MapView from "react-native-map-clustering";
import { Marker } from "react-native-maps";

function getRandomLatitude(min = 48, max = 56) {
  return Math.random() * (max - min) + min;
}

function getRandomLongitude(min = 14, max = 24) {
  return Math.random() * (max - min) + min;
}

const INITIAL_REGION = {
  latitude: 52.5,
  longitude: 19.2,
  latitudeDelta: 8.5,
  longitudeDelta: 8.5
};

function MapClusteringExample() {
  const _generateMarkers = (count: number) => {
    const markers = [];

    for (let i = 0; i < count; i++) {
      markers.push(
        <Marker

          title='456'
          key={i}
          coordinate={{
            latitude: getRandomLatitude(),
            longitude: getRandomLongitude()
          }}
        />
      );
    }

    return markers;
  };

  return (
    <MapView initialRegion={INITIAL_REGION}
      style={{ flex: 1 }}
    >
      {_generateMarkers(200)}
    </MapView>
  );
};



//export default App
export default MapClusteringExample;