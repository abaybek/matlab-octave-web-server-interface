function response = plotlyoffline(plotlyfig)
    % Generate offline Plotly figure saved as an html file within
    % the current working directory. The file will be saved as:
    % 'plotlyfig.PlotOptions.FileName'.html.

    % create dependency string unless not required
    if plotlyfig.PlotOptions.IncludePlotlyjs
        % grab the bundled dependencies
        userhome = getuserdir();
        plotly_config_folder   = fullfile(userhome,'.plotly');
        plotly_js_folder = fullfile(plotly_config_folder, 'plotlyjs');
        % bundle_name = 'plotly-matlab-offline-bundle.js';
        % bundle_file = fullfile(plotly_js_folder, bundle_name);
        bundle_name = 'plotly-latest.js';
        bundle_file = which(bundle_name);

        % check that the bundle exists
        % try
        %     bundle = fileread(bundle_file);
        %     % template dependencies
        %     dep_script = sprintf('<script type="text/javascript">%s</script>\n', ...
        %         bundle);
        % catch
        %     error(['Error reading: %s.\nPlease download the required ', ...
        %            'dependencies using: >>getplotlyoffline \n', ...
        %            'or contact support@plot.ly for assistance.'], ...
        %            bundle_file);
        % end
    else
        dep_script = '';
    end

    % handle plot div specs
    % id = char(java.util.UUID.randomUUID);
    id = l_get_uid(36);
    width = [num2str(plotlyfig.layout.width) 'px'];
    height = [num2str(plotlyfig.layout.height) 'px'];
    if plotlyfig.PlotOptions.ShowLinkText
        link_text = plotlyfig.PlotOptions.LinkText;
    else
        link_text = '';
    end

    % format the data and layout
    plotlyfig.layout = rmfield( plotlyfig.layout, 'width' );
    plotlyfig.layout = rmfield( plotlyfig.layout, 'height' );
    plotlyfig.layout.autolayout = true;
    jdata = m2json(plotlyfig.data);
    jlayout = m2json(plotlyfig.layout);
    % clean_jdata = escapechars(jdata);
    % clean_jlayout = escapechars(jlayout);
    clean_jdata = jdata;
    clean_jlayout = jlayout;

    % template environment vars
    plotly_domain = plotlyfig.UserData.PlotlyDomain;
    env_script = sprintf(['<script type="text/javascript">', ...
                          'window.PLOTLYENV=window.PLOTLYENV || {};', ...
                          'window.PLOTLYENV.BASE_URL="%s";', ...
                          'Plotly.LINKTEXT="%s";', ...
                          '</script>'], plotly_domain, link_text);

    % template Plotly.plot
    script = sprintf(['\n Plotly.plot("%s", %s, %s);'], id, clean_jdata, clean_jlayout);

    plotly_script = sprintf(['\n<div id="%s" style="height: 100%%;',...
                             'width: 100%%;" class="plotly-graph-div">' ...
                             '</div> \n<script type="text/javascript">' ...
                             '%s \n</script>'], id, ... %height, width, ...
                            script);

    h = plotlyfig.State.Figure.Handle;
    if( exist( 'OCTAVE_VERSION', 'builtin' ) || verLessThan('matlab','8.4.0') )
      s_fignum = num2str(h);
    else
      s_fignum = num2str(get(h,'Number'));
    end

    % template entire script
    % dep_script = strrep( dep_script, '\', '\\' );
    dep_script = '<script src="assets/js/plotly-latest.min.js"></script>';
    % offline_script = [dep_script env_script plotly_script]
    offline_script = ['<!DOCTYPE html><html><head><title>Figure ',s_fignum,'</title>',dep_script,'</head><body margin:0;height:100vh;>',plotly_script,'</body></html>'];
    filename = plotlyfig.PlotOptions.FileName;

    % remove the whitespace from the filename
    clean_filename = filename(filename~= ' ' );
    html_filename = [ clean_filename '.html'];

    % save the html file in the working directory
    plotly_offline_file = fullfile(tempdir, html_filename);
    file_id = fopen(plotly_offline_file, 'w');
    fprintf(file_id, '%s', offline_script);
    fclose(file_id);

    % remove any whitespace from the plotly_offline_file path
    plotly_offline_file = strrep(plotly_offline_file, ' ', '%20');

    % return the local file url to be rendered in the browser
    % response = ['file://' plotly_offline_file];
    response = [plotly_offline_file];

end

%-------------------------------------------------------------------------%
function [ s_uid, uid ] = l_get_uid( n )
% Unique (random) user id.

uid = zeros(1,n);
ix  = (uid>=48&uid<=57) | (uid>=65&uid<=90) | (uid>=97&uid<=122);
while( ~all(ix) )
  ix = (uid>=48&uid<=57) | (uid>=65&uid<=90) | (uid>=97&uid<=122);
  uid(~ix) = randi( 122, 1, sum(~ix) );
end
s_uid = char(uid);

end
