function line = extractLineLine(line_data)

% EXTRACTS THE LINE STYLE USED FOR MATLAB OBJECTS
% OF TYPE "LINE". THESE OBJECTS ARE USED IN LINESERIES,
% STAIRSERIES, STEMSERIES, BASELINESERIES, AND BOXPLOTS

%-------------------------------------------------------------------------%

%-INITIALIZE OUTPUT-%
line = struct();

%-------------------------------------------------------------------------%
if( exist( 'OCTAVE_VERSION', 'builtin' ) )

if(~strcmp(line_data.linestyle,'none'))

    %-SCATTER LINE COLOR (STYLE)-%
    col = 255*line_data.Color;
    line.color = ['rgb(' num2str(col(1)) ',' num2str(col(2)) ',' num2str(col(3)) ')'];

    %---------------------------------------------------------------------%

    %-SCATTER LINE WIDTH (STYLE)-%
    line.width = line_data.linewidth;

    %---------------------------------------------------------------------%

    %-SCATTER LINE DASH (STYLE)-%
    switch line_data.linestyle
        case '-'
            LineStyle = 'solid';
        case '--'
            LineStyle = 'dash';
        case ':'
            LineStyle = 'dot';
        case '-.'
            LineStyle = 'dashdot';
    end

    line.dash = LineStyle;

    %---------------------------------------------------------------------%

end
else

  if(~strcmp(line_data.LineStyle,'none'))

    %-SCATTER LINE COLOR (STYLE)-%
    col = 255*line_data.Color;
    line.color = ['rgb(' num2str(col(1)) ',' num2str(col(2)) ',' num2str(col(3)) ')'];

    %---------------------------------------------------------------------%

    %-SCATTER LINE WIDTH (STYLE)-%
    line.width = line_data.LineWidth;

    %---------------------------------------------------------------------%

    %-SCATTER LINE DASH (STYLE)-%
    switch line_data.LineStyle
      case '-'
        LineStyle = 'solid';
      case '--'
        LineStyle = 'dash';
      case ':'
        LineStyle = 'dot';
      case '-.'
        LineStyle = 'dashdot';
    end

    line.dash = LineStyle;

    %---------------------------------------------------------------------%

  end
end
