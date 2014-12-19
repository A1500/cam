package com.inspur.sdmz.jtxx.domain;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.sdmz.comFamilyOrgan.dao.ComFamilyOrgan;
import com.inspur.sdmz.jtxx.data.SamFamilyHouse;
import com.inspur.sdmz.jtxx.data.SamPeopleDisability;
import com.inspur.sdmz.jtxx.data.SamPeopleDisease;
import com.inspur.sdmz.jtxx.data.SamPeopleEdu;
import com.inspur.sdmz.jtxx.data.SamPeopleAccident;
import com.inspur.sdmz.jtxx.data.BaseinfoFamily;
import com.inspur.sdmz.jtxx.data.BaseinfoPeople;
import com.inspur.sdmz.jtxx.data.SamFamilyAssistance;
import com.inspur.sdmz.jtxx.data.SamFamilyCalamity;
import com.inspur.sdmz.jtxx.data.SamIndex;

/**
 * @title:IYgjzJtxxDomain
 * @description:
 * @author:
 * @since:2011-04-18
 * @version:1.0
*/
 public interface IYgjzJtxxDomain {
	@Trans
    public void saveYgjzJtxx(List<BaseinfoFamily> list);
    @Trans
    public void updateYgjzJtxx(List<BaseinfoFamily> list);
    @Trans
	public void saveYgjzJtxxCyxx(List<BaseinfoPeople> list);
    @Trans
	public DataSet queryYgjzJtxxCyxx(ParameterSet pset);
    @Trans
	public void saveYgjzJtxxCyxxList(BaseinfoFamily ygjzjtxx, List<BaseinfoPeople> list,List<SamPeopleDisability> cjxxlist,List<SamPeopleEdu>YgjzCyxxJyxxList,List<SamPeopleDisease>YgjzCyxxHbxxList,List <SamPeopleAccident>YgjzCyxxSgxxList);

	@Trans
	public void saveSamFamilyAssistance(List<SamFamilyAssistance> list,String jtid);
	@Trans
	public void saveSamFamilyAssistance(List<SamFamilyAssistance> list);
	@Trans
	public DataSet querySamFamilyAssistance(ParameterSet pset);
	public void saveSamFamilyAssistanceList(BaseinfoFamily ygjzjtxx, List<SamFamilyAssistance> list);
	@Trans
	public void bathchDeleteByFamilyId(String[] delIds);
	@Trans
	public void saveYgjzJtxxZrzh(List<SamFamilyCalamity> list);
	@Trans
	public DataSet queryYgjzJtxxZrzh(ParameterSet pset);
	public void saveYgjzJtxxZrzhList(BaseinfoFamily ygjzjtxx, List<SamFamilyCalamity> list);

	@Trans
	public void saveYgjzJzzs(List<SamIndex> list);
	@Trans
	public DataSet queryYgjzJzzs(ParameterSet pset);
	public void saveYgjzJzzsList(BaseinfoFamily ygjzjtxx, List<SamIndex> list);

	public DataSet queryYgjzJtxx(ParameterSet pset);
	@Trans
	public void delete(List<String> list);
	// 更新成员数量
	@Trans
	public void updatePeopleNum(String familyId) ;
	// 更改当前环节
	@Trans
	public void updateCurrentActivity(String activity,String jtids,String createOrgan) ;
	// 计算并保存救助指数
	@Trans
	public void countJtxxJzzs(BaseinfoFamily ygjzJtxx);
	// 计算并保存救助指数
	public void countJtxxJzzs(String familyId);
	//更新救助指数
	//public void updateJzzs(String jtidStr);
	//更新计算状态
	@Trans
	public DataSet itemQuery(ParameterSet pset,HttpServletRequest request);
	@Trans
	public void saveYgjzJtxxSzlx(List<SamFamilyAssistance> list);
	@Trans
    public void HouseInsert(SamFamilyHouse samFamilyHouse);
	@Trans
    public void HouseUpdate(SamFamilyHouse samFamilyHouse);
	@Trans
	public void FamilyInsert(ComFamilyOrgan comFamilyOrgan);
	@Trans
	public void FamilyUpdate(ComFamilyOrgan comFamilyOrgan);
 }