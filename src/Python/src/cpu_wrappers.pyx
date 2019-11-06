# distutils: language=c++
"""
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at
    http://www.apache.org/licenses/LICENSE-2.0
Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
"""

import cython
import numpy as np
cimport numpy as np

cdef extern float RingWeights_main(float *residual, float *weights, int half_window_size, long anglesDim, long detectorsDim, long slices);

##############################################################################
def RING_WEIGHTS(residual, half_window_size):
    if residual.ndim == 2:
        return RING_WEIGHTS_2D(residual, half_window_size)
    elif residual.ndim == 3:
        return 0

def RING_WEIGHTS_2D(np.ndarray[np.float32_t, ndim=2, mode="c"] residual,                    
                     int half_window_size):

    cdef long dims[2]
    dims[0] = residual.shape[0]
    dims[1] = residual.shape[1]

    cdef np.ndarray[np.float32_t, ndim=2, mode="c"] weights = \
            np.zeros([dims[0],dims[1]], dtype='float32')

    RingWeights_main(&residual[0,0], &weights[0,0], half_window_size, dims[1], dims[0], 1);
    
    return weights
"""
def MASK_CORR_2D(np.ndarray[np.uint8_t, ndim=2, mode="c"] maskData,
                    np.ndarray[np.uint8_t, ndim=1, mode="c"] select_classes_ar,
                    np.ndarray[np.uint8_t, ndim=1, mode="c"] combo_classes_ar,
                     int total_classesNum,
                     int CorrectionWindow,
                     int iterationsNumb):

    cdef long dims[2]
    dims[0] = maskData.shape[0]
    dims[1] = maskData.shape[1]

    select_classes_length = select_classes_ar.shape[0]
    tot_combinations = (int)(combo_classes_ar.shape[0]/int(4))

    cdef np.ndarray[np.uint8_t, ndim=2, mode="c"] mask_upd = \
            np.zeros([dims[0],dims[1]], dtype='uint8')
    cdef np.ndarray[np.uint8_t, ndim=2, mode="c"] corr_regions = \
            np.zeros([dims[0],dims[1]], dtype='uint8')

    # Run the function to process given MASK
    Mask_merge_main(&maskData[0,0], &mask_upd[0,0],
                    &corr_regions[0,0], &select_classes_ar[0], &combo_classes_ar[0], tot_combinations, select_classes_length,
                    total_classesNum, CorrectionWindow,
                    iterationsNumb, dims[1], dims[0], 1)
    return mask_upd

def MASK_CORR_3D(np.ndarray[np.uint8_t, ndim=3, mode="c"] maskData,
                    np.ndarray[np.uint8_t, ndim=1, mode="c"] select_classes_ar,
                    np.ndarray[np.uint8_t, ndim=1, mode="c"] combo_classes_ar,
                     int total_classesNum,
                     int CorrectionWindow,
                     int iterationsNumb):

    cdef long dims[3]
    dims[0] = maskData.shape[0]
    dims[1] = maskData.shape[1]
    dims[2] = maskData.shape[2]

    select_classes_length = select_classes_ar.shape[0]
    tot_combinations = (int)(combo_classes_ar.shape[0]/int(4))

    cdef np.ndarray[np.uint8_t, ndim=3, mode="c"] mask_upd = \
            np.zeros([dims[0],dims[1],dims[2]], dtype='uint8')
    cdef np.ndarray[np.uint8_t, ndim=3, mode="c"] corr_regions = \
            np.zeros([dims[0],dims[1],dims[2]], dtype='uint8')

   # Run the function to process given MASK
    Mask_merge_main(&maskData[0,0,0], &mask_upd[0,0,0],
                    &corr_regions[0,0,0], &select_classes_ar[0], &combo_classes_ar[0], tot_combinations, select_classes_length,
                    total_classesNum, CorrectionWindow,
                    iterationsNumb, dims[2], dims[1], dims[0])
    return mask_upd
"""