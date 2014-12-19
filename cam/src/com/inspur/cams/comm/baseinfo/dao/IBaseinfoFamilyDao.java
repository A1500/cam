package com.inspur.cams.comm.baseinfo.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;

import com.inspur.cams.comm.baseinfo.data.BaseinfoFamily;



/**
 * @title:IBaseinfoFamilyDao
 * @description:
 * @author:
 * @since:2011-05-12
 * @version:1.0
*/
 public interface IBaseinfoFamilyDao extends BaseCURD<BaseinfoFamily>{
	public void save(List<BaseinfoFamily> list);
	// 更新成员数量
	public void updatePeopleNum(String jtid) ;
	// 根据人员月收入更新家庭收入
	public void updateIncomeByMonth(String familyId);
	// 根据人员年收入更新家庭收入
	public void updateIncomeByYear(String familyId);
	//更改当前环节
	public void updateCurrentActivity(String activity,String jtids,String createOrgan) ;
	//更新计算状态
	public void updateJtdz(String jtid) ;
	/**
	 * 低保查询家庭基本信息
	 * @return
	 */
	public DataSet querySamFamily(ParameterSet pset);

	/**
	* @Title: querySamFamilyList
	* @Description: TODO(家庭信息列表查询，专项救助列表查询使用)
	* @param pset
	* @return DataSet  
	* @throws
	* @author luguosui
	 */
	public DataSet querySamFamilyList(ParameterSet pset);
	
	/**
	 * @Title: querySamBankList 
	 * @Description: TODO(银行账户维护列表查询) 
	 * @author wangziming
	 */
	public DataSet querySamBankList(ParameterSet pset);
	/**
	 * @Title: queryBaseChange 
	 * @Description: TODO(低保变动) 
	 * @author sunlei
	 */
	public DataSet queryBaseChange(ParameterSet pset);
	/**
	 * 调用存储过程把记录保存到备用表中
	 */
	public void procSamFamily(BaseinfoFamily baseinfoFamily);
	/**
	* @Title: insertFamilyFromEnsurey
	* @Description: TODO(从经济核对回填家庭信息)
	* @param set void  
	* @throws
	* @author luguosui
	 */
	public Record insertFamilyFromEnsurey(ParameterSet set);
	
	public DataSet querySamFamilyListForRecheck(ParameterSet pset);
	
}

