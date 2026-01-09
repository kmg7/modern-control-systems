w = 0.0011;

A = [0 1 0 0; 3*w^2 0 0 2*w; 0 0 0 1; 0 -2*w 0 0];
B_rad = [0; 1; 0; 0];
B_tan = [0; 0; 0; 1];

Pc_rad = ctrb(A, B_rad);
det_rad = det(Pc_rad);

Pc_tan = ctrb(A, B_tan);
det_tan = det(Pc_tan);

sat_is_not_controllable_with_radial_thruster_only = abs(det_rad) < eps
sat_is_not_controllable_with_tangential_thruster_only = abs(det_tan) < eps