classdef TestHausdorffDistanceExtractor
    %TestHausdorffDistanceExtractor

    methods (Static)
        function test_1
            img1 = cv.imread(fullfile(mexopencv.root(),'test','shape03.png'), ...
                'Grayscale',true, 'ReduceScale',2);
            img2 = cv.imread(fullfile(mexopencv.root(),'test','shape04.png'), ...
                'Grayscale',true, 'ReduceScale',2);
            c1 = cv.findContours(img1, 'Mode','List', 'Method','TC89_L1');
            c2 = cv.findContours(img2, 'Mode','List', 'Method','TC89_L1');
            [~,idx] = max(cellfun(@numel,c1));  % largest contour
            c1 = c1{idx};  % cell array of 2D points
            [~,idx] = max(cellfun(@numel,c2));  % largest contour
            c2 = c2{idx};  % cell array of 2D points

            sc = cv.HausdorffDistanceExtractor('RankProportion',0.6);
            sc.DistanceFlag = 'L2';
            assert(abs(sc.RankProportion - 0.6) < 1e-6);

            d = sc.computeDistance(c1, c2);
            validateattributes(d, {'numeric'}, {'scalar', 'real'});
        end
    end

end
