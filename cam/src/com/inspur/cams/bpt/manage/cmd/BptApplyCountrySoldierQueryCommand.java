package com.inspur.cams.bpt.manage.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.bpt.base.dao.IBptApplyMartyrOffspringDao;
import com.inspur.cams.bpt.base.dao.jdbc.BptCountRetiredSoldierDao;
import com.inspur.cams.bpt.manage.domain.IBptGroupDomain;

/**
 * @title:BptApplyCountrySoldierQueryCommand
 * @description: 60周岁以上农村籍退役士兵 查询command
 * @author:
 * @since:
 * @version:
*/
public class BptApplyCountrySoldierQueryCommand extends BaseQueryCommand{
	private IBptGroupDomain service = ScaComponentFactory.getService(
			IBptGroupDomain.class, "bptGroupDomain/bptGroupDomain");
	public DataSet execute(){
		ParameterSet pset = getParameterSet();
		IBptApplyMartyrOffspringDao dao = (IBptApplyMartyrOffspringDao) DaoFactory
				.getDao("com.inspur.cams.bpt.base.dao.jdbc.BptApplyMartyrOffspringDao");
		return dao.query(pset);
	}
	
	/**
	 * 查询未提交60周岁以上农村籍退役士兵列表信息
	 */
	public DataSet queryUnComCountSold(){
		ParameterSet pset = getParameterSet();
		IBptApplyMartyrOffspringDao dao = (IBptApplyMartyrOffspringDao)DaoFactory.getDao("com.inspur.cams.bpt.base.dao.jdbc.BptApplyMartyrOffspringDao");
		return dao.queryUnComCountSold(pset);
	}
	/**
	 * 
	 * 查询 已提交 60周岁以上农村籍退役士兵
	 * @param pset
	 * @return
	 */
	public DataSet queryCountrysoldier(){
		ParameterSet pset = getParameterSet();
		IBptApplyMartyrOffspringDao dao = (IBptApplyMartyrOffspringDao)DaoFactory.getDao("com.inspur.cams.bpt.base.dao.jdbc.BptApplyMartyrOffspringDao");
		return dao.queryCountrysoldier(pset);
	}
	
	/**
	 * 通过id_card查询60周岁以上农村籍退役士兵信息
	 * 
	 * @return
	 */
	public DataSet queryByIdCard() {
		BptCountRetiredSoldierDao dao = (BptCountRetiredSoldierDao) DaoFactory
		.getDao("com.inspur.cams.bpt.base.dao.jdbc.BptCountRetiredSoldierDao");
		ParameterSet pset = getParameterSet();
		DataSet ds = new DataSet();
		DataSet basepeopleDs = service.queryPeople(pset); // 人员基本信息
		if (basepeopleDs.getCount() != 0) {
			Record record = (Record) basepeopleDs.getRecord(0);
			record.set("domicileName","");//与迁移字段重复 设空
			pset.clear();
			pset.setParameter("PEOPLE_ID", record.get("peopleId"));
			DataSet sDs = dao.query(pset); // 子女信息
			if (sDs.getCount() != 0) {
				Record sRecord = sDs.getRecord(0);
				record.set("conscriptDate", sRecord.get("conscriptDate"));
				record.set("decruitmentDate", sRecord.get("decruitmentDate"));
				record.set("retiredNo", sRecord.get("retiredNo"));
				record.set("forcesName", sRecord.get("forcesName"));
				record.set("forcesNo", sRecord.get("forcesNo"));
				record.set("soldierStartDate", sRecord.get("soldierStartDate"));
				record.set("soldierEndDate", sRecord.get("soldierEndDate"));
				record.set("soldierYears", sRecord.get("soldierYears"));
				ds.add(record);
			}

		}
		return ds;
	}
}
