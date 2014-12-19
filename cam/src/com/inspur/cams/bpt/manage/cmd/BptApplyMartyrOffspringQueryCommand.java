package com.inspur.cams.bpt.manage.cmd;


import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.bpt.base.domain.IBptApplyMartyrOffspringDomain;
import com.inspur.cams.bpt.base.domain.IBptPeopleMartyrOffspringDomain;
import com.inspur.cams.bpt.manage.domain.IBptGroupDomain;


/**
 * @title:BptApplyMartyrOffspringQueryCommand
 * @description:
 * @author:
 * @since:
 * @version:
 */
public class BptApplyMartyrOffspringQueryCommand extends BaseQueryCommand{
	IBptGroupDomain service = ScaComponentFactory.getService(
			IBptGroupDomain.class, "bptGroupDomain/bptGroupDomain");
	/**
	 * 查询未提交部分烈士（错杀被平反人员）子女人员信息
	 */
	public DataSet queryUnCommitRecord(){
		ParameterSet pset = getParameterSet();
		IBptApplyMartyrOffspringDomain applyMartyrOffspringDomain = (IBptApplyMartyrOffspringDomain)ScaComponentFactory.getService(IBptApplyMartyrOffspringDomain.class,"bptApplyMartyrOffspringDomain/bptApplyMartyrOffspringDomain");
		DataSet ds = applyMartyrOffspringDomain.queryUnCommitRecord(pset);
		return ds;
	}
	
	/**
	 * 查询部分烈士（错杀被平反人员）子女申请信息
	 * @return
	 */
	public DataSet execute(){
		ParameterSet pset = getParameterSet();
		IBptApplyMartyrOffspringDomain applyMartyrOffspringDomain = (IBptApplyMartyrOffspringDomain)ScaComponentFactory.getService(IBptApplyMartyrOffspringDomain.class,"bptApplyMartyrOffspringDomain/bptApplyMartyrOffspringDomain");
		return applyMartyrOffspringDomain.query(pset);
	}
	
	/**
	 * 通过id_card查询部分烈士（错杀被平反人员）子女信息
	 * 
	 * @return
	 */
	public DataSet queryByIdCard() {
		IBptPeopleMartyrOffspringDomain martyrOffspringDomain = (IBptPeopleMartyrOffspringDomain)ScaComponentFactory.getService(IBptPeopleMartyrOffspringDomain.class, "bptPeopleMartyrOffspringDomain/bptPeopleMartyrOffspringDomain");
		ParameterSet pset = getParameterSet();
		DataSet ds = new DataSet();
		DataSet basepeopleDs = service.queryPeople(pset); // 人员基本信息
		if (basepeopleDs.getCount() != 0) {
			Record record = (Record) basepeopleDs.getRecord(0);
			record.set("domicileName","");//与迁移字段重复 设空
			pset.clear();
			pset.setParameter("PEOPLE_ID", record.get("peopleId"));
			DataSet testDs = martyrOffspringDomain.query(pset); // 子女信息
			if (testDs.getCount() != 0) {
				Record testRecord = testDs.getRecord(0);
				record.set("statusType", testRecord.get("statusType"));
				record.set("sacrificeDate", testRecord.get("sacrificeDate"));
				record.set("lezswApproveDate", testRecord.get("lezswApproveDate"));
				ds.add(record);
			}

		}
		return ds;
	}
	/**
	 * 
	 * 查询 已提交 部分烈士（错杀被平反人员）子女申请信息
	 * @param pset
	 * @return
	 */
	public DataSet queryMartyrOffspirng(){
		IBptApplyMartyrOffspringDomain applyMartyrOffspringDomain = (IBptApplyMartyrOffspringDomain)ScaComponentFactory.getService(IBptApplyMartyrOffspringDomain.class,"bptApplyMartyrOffspringDomain/bptApplyMartyrOffspringDomain");
		ParameterSet pset = getParameterSet();
		DataSet ds = new DataSet();
		return applyMartyrOffspringDomain.queryMartyrOffspirng(pset);
	}
}
