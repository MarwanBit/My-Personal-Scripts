%In this matlab file we will write the code which will be used to generate
%the cage for our accelerometer...

function cage = generate_cage( ...
    gd_structure,...
    write_to_lib)
    
    %{
    This function generates a cage for our accelerometer
    %}

    %create new structure for if we want to write to the library 
    temp_gds_return_structure = gds_structure('accelerometer cage');

    %now we generate the bounding box for the structure
    boundary_box_cage = bbox(gd_structure);

    %now we see if we get the boundary box and append it to gd_structure
    llx = boundary_box_cage(0);
    lly = boundary_box_cage(1);
    urx = boundary_box_cage(2);
    ury = boundary_box_cage(3);
    width = urx - llx;
    length = ury - lly;

    cage_box = 1000*[
        llx,lly;
        llx,lly+length;
        llx+width,lly+length;
        llx+width,lly;
        llx,lly;   
        ];

    %now that we have our cage box we can add it to the structure
    gd_structure(end+1) = gds_element('boundary', 'xy',cage_box, 'layer',0);
    temp_gds_return_structure(end+1) = gds_element('boundary', 'xy',cage_box, 'layer',0);

    %now have the cage :)
    cage = gd_structure;

   
    %now let's consider the case where we want to write to our library
    if write_to_lib == true
        %if we want to write to library add this structure to our
         %temp_structure
         glib = gds_library('cage', 'uunit','1e6', 'dbunit','1e9', temp_gds_return_structure);
         %now we write this library
         write_gds_library(glib, '!cage.gds');
    
    end


end


    

