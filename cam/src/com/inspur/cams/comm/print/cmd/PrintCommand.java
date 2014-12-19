package com.inspur.cams.comm.print.cmd;
import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.sca.api.Service;

import com.inspur.cams.comm.print.dao.IPrintDao;
/**
 * @title:FormPrintCommand
 * @description:套字打印公用command
 * @author:
 * @since:2011-05-31
 * @version:1.0
*/
public class PrintCommand extends BaseQueryCommand{
	
	 
	/**
	 * 根据前台传参判断调用的查询方法
	 * @return
	 */
	public DataSet queryData() {
		String path = (String)getParameter("scaconfPath");
		IPrintDao dao = ScaComponentFactory.getService(IPrintDao.class, path);
		ParameterSet pst =  getParameterSet();
		Service service = ScaComponentFactory.getService(path);
		String entity = service.getComponent().getImplDesc();
		Object obj = DaoFactory.getDao(entity);
		return dao.execute(obj,pst);
	}
	
}
