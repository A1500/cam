package com.inspur.cams.drel.sam.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.comm.baseinfo.data.BaseinfoFamily;
import com.inspur.cams.comm.baseinfo.data.BaseinfoPeople;
import com.inspur.cams.drel.sam.data.SamFamilyAssistance;
import com.inspur.cams.drel.sam.data.SamFamilyCalamity;
/**
 * @title:IBaseinfoFamilyDomain
 * @description:
 * @author:
 * @since:2011-04-18
 * @version:1.0
*/
 public interface IBaseinfoFamilyDomain {

    public void saveYgjzJtxx(List<BaseinfoFamily> list);
	public void saveYgjzJtxxCyxx(List<BaseinfoPeople> list);
	public DataSet queryYgjzJtxxCyxx(ParameterSet pset);
	public void saveYgjzJtxxCyxxList(BaseinfoFamily ygjzjtxx, List<BaseinfoPeople> list);


	public void saveSamFamilyAssistance(List<SamFamilyAssistance> list,String jtid);
	public void saveSamFamilyAssistance(List<SamFamilyAssistance> list);
	public DataSet querySamFamilyAssistance(ParameterSet pset);
	public void saveSamFamilyAssistanceList(BaseinfoFamily ygjzjtxx, List<SamFamilyAssistance> list);


	public DataSet queryYgjzJtxx(ParameterSet pset);

	public void delete(List<String> list);
	// 更新成员数量
	public void updatePeopleNum(String jtid) ;
	// 更改当前环节
	public void updateCurrentActivity(String activity,String jtids,String createOrgan) ;
	//更新计算状态
	public void updateJtdz(String jtids) ;
	public DataSet itemQuery(ParameterSet pset);
	//更新家庭信息
	public void updateFamily(BaseinfoFamily baseinfoFamily);

	//自然灾害保存
	public void saveYgjzJtxxZrzh(List<SamFamilyCalamity> list);
	public DataSet queryJtxxZrzh(ParameterSet pset);
	/**
	 * 低保查询家庭基本信息
	 * @return
	 */
	public DataSet querySamFamily(ParameterSet pset);
	
 }