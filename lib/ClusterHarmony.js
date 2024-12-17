/*
 * Copyright (c) 2024 Huawei Device Co., Ltd. All rights reserved
 * Use of this source code is governed by a MIT license that can be
 * found in the LICENSE file.
 */

import React, { memo } from "react";
import { Cluster } from "react-native-maps";

const ClusterHarmony = ({ marker, distance, onPress }) => {
  return (
    <Cluster
      clusterItems={marker.clusterChildItem}
      distance={distance ? distance : 40}
      onPress={onPress}
      style={{ zIndex: marker.properties.point_count + 1 }}
    ></Cluster>
  );
};

export default memo(ClusterHarmony);
