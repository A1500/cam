package com.inspur.cams.comm.dicm.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.dicm.domain.IDicDetailsDomain;

/***
 * 字典详细信息查询command
 * @author luguosui
 * @date 2011-8-31
 */
public class DicDetailsQueryCmd extends BaseQueryCommand {
	@Reference
	private IDicDetailsDomain dicDetailsDomain=ScaComponentFactory.getService(IDicDetailsDomain.class, "DicDetailsDomain/DicDetailsDomain");

	
	public DataSet execute(){
		ParameterSet pset = getParameterSet();
		return dicDetailsDomain.query(pset);
	}
	


	/**
	 * 页面显示字典表时调用查询方法
	 * @param pset
	 * @return
	 */
	public DataSet queryForDic(){
		ParameterSet pset = getParameterSet();
		DataSet ds = dicDetailsDomain.queryForDic(pset);
//		ds.getMetaData().setIdProperty("CODE");
		ds.getMetaData().setIdProperty("value");
		return ds;
	}


	/**
	 * 页面显示字典表时调用查询方法（通用）
	 * @param pset
	 * @return
	 */
	public DataSet queryForGeneralDic(){
		ParameterSet pset = getParameterSet();
		return dicDetailsDomain.queryForGeneralDic(pset);
	}
}
