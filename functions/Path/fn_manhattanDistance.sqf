params ["_pointA", "_pointB"];

abs (_pointA # 0 - _pointB # 0) + abs (_pointA # 1 - _pointB # 1)
