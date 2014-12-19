package com.inspur.cams.drel.sam.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.baseinfo.domain.IBaseinfoDomain;

/**
 * @title:家庭信息查询Command
 * @description:
 * @author: yanll
 * @since:2012-05-03
 * @version:1.0
*/
@SuppressWarnings("unchecked")
public class BaseinfoFamilyQueryCmd extends BaseQueryCommand{
	
	IBaseinfoDomain baseinfoDomain = ScaComponentFactory.getService(IBaseinfoDomain.class, "baseinfoDomain/baseinfoDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return baseinfoDomain.queryFamily(pset);
	}

	/**
	* @Title: querySamFamilyList
	* @Description: TODO(家庭信息列表查询，专项救助列表查询使用)
	* @return DataSet  
	* @throws
	* @author luguosui
	 */
	public DataSet querySamFamilyList(){
		ParameterSet pset = getParameterSet();
		return baseinfoDomain.querySamFamilyList(pset);
	}
	/**
	 * @Title: querySamBankList 
	 * @Description: TODO(银行账户维护列表查询) 
	 * @author wangziming
	 */
	public DataSet querySamBankList(){
		ParameterSet pset = getParameterSet();
		return baseinfoDomain.querySamBankList(pset);
	}
	public DataSet queryBaseChange(){
		ParameterSet pset = getParameterSet();
		return baseinfoDomain.queryBaseChange(pset);
	}
	
	public DataSet querySamFamilyListForRecheck(){
		ParameterSet pset = getParameterSet();
		return baseinfoDomain.querySamFamilyListForRecheck(pset);
	}
}
