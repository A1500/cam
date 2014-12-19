package com.inspur.cams.comm.menuconfig.cmd;

import org.loushang.bsp.organization.dao.StruDao;
import org.loushang.bsp.share.organization.bean.StruView;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.menuconfig.dao.IMenuConfigSearchDao;

/**
 *
 * @param req
 * @param rep
 * @param errorHandler
 * @param messageHandler
 * @param viewHelper
 * @return 功能：获得组织机构树
 */

public class MenuConfigCommand extends BaseQueryCommand {
	private IMenuConfigSearchDao menuConfigSearchDao = (IMenuConfigSearchDao)ScaComponentFactory.getService(IMenuConfigSearchDao.class,"MenuConfigSearchDao/MenuConfigSearchDao");
	private StruDao StruDao = (StruDao)ScaComponentFactory.getService(StruDao.class,"StruDao/StruDao");
	/**
	 * 获取该组织下所有员工
	 * @return
	 */
	public DataSet getUnderlingByOrganType() {
		DataSet ds = new DataSet();
		ParameterSet param = getParameterSet();
		// 从前台传递过来的参数
		String struId = (String) param.getParameter("struId");
		Record record = (Record) getParameter("record");
		StruView struView = new StruView();
		if (struId.equals("rootId")) {
			struView = (StruView) record.toBean(StruView.class);
		} else {
			struView = StruDao.getStruView(struId);
		}
		param.setParameter("organTypeIdq", "8");
		ds = menuConfigSearchDao.getQueryUnderling(struView, param);
		return ds;
	}
	
	public DataSet getMenuType(){
		DataSet ds = new DataSet();
		ParameterSet pset = getParameterSet();
		ds = menuConfigSearchDao.getMenuType(pset);
		return ds;
	}
	

}
