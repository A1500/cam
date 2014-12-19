package com.inspur.cams.comm.menuconfig.dao;

import org.loushang.bsp.organization.data.Stru;
import org.loushang.bsp.share.organization.bean.StruView;
import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

public interface IMenuConfigSearchDao extends BaseCURD<Stru>{
	public DataSet getQueryUnderling(StruView struView, ParameterSet param) ;
	

	public DataSet getMenuType(ParameterSet pset);
}
