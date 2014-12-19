package com.inspur.sdmz.comm.analysis.downLoadSVG;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.loushang.next.web.cmd.BaseDispatcherCommand;

public class DownLoadSvg extends BaseDispatcherCommand {
	public void execute() {
		try {
			HttpServletResponse response = getResponse();
			HttpServletRequest request = getRequest();
			String realPath = request.getSession().getServletContext().getRealPath("/");
			File svgFile = new File(realPath.replace("\\", "/")+"WEB-INF/classes/com/inspur/sdmz/comm/analysis/downLoadSVG/SVGView.exe");
			if(svgFile.exists()) {
				FileInputStream fis = new FileInputStream(svgFile);
	            response.reset();
	            response.setContentType("application/octet-stream");
	            response.addHeader("Content-Disposition", "attachment;filename=SVGView.exe");
	            OutputStream output = response.getOutputStream();
	            byte b[] = new byte[1024];
	            for (int i = 0; (i = fis.read(b)) > 0;)
	                output.write(b, 0, i);
	            output.flush();
	            fis.close();
	            output.close();
			} else {
				throw new RuntimeException("未查找到SVGView的安装文件");
			}
		} catch(IOException e) {
			throw new RuntimeException("下载失败！");
		}
	}
}
