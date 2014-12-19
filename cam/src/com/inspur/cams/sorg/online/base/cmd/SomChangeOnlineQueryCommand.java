package com.inspur.cams.sorg.online.base.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.comm.util.StrUtil;
import com.inspur.cams.sorg.base.dao.jdbc.SomOrganDao;
import com.inspur.cams.sorg.base.data.SomChange;
import com.inspur.cams.sorg.base.data.SomOrgan;
import com.inspur.cams.sorg.online.base.dao.support.SomChangeOnlineDao;
import com.inspur.cams.sorg.online.base.data.SomChangeOnline;

/**
 * @title:SomChangeOnlineQueryCommand
 * @description:
 * @author:
 * @since:2012-11-12
 * @version:1.0
*/
public class SomChangeOnlineQueryCommand extends BaseQueryCommand{
	
	private SomChangeOnlineDao onlineDao = (SomChangeOnlineDao) DaoFactory
	.getDao("com.inspur.cams.sorg.online.base.dao.support.SomChangeOnlineDao");
	
	private SomOrganDao organDao = (SomOrganDao) DaoFactory
	.getDao("com.inspur.cams.sorg.base.dao.jdbc.SomOrganDao");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomChangeOnline> dao = (EntityDao<SomChangeOnline>) DaoFactory
				.getDao("com.inspur.cams.sorg.online.base.dao.support.SomChangeOnlineDao");
		return dao.query(pset);
	}
	
	public DataSet queryAndBuildGroup() {
		DataSet returnDs = new DataSet();
		ParameterSet pset = getParameterSet();
		String taskCode = (String) pset.getParameter("TASK_CODE");
		String cnName = (String) pset.getParameter("CN_NAME");
		pset.remove("CN_NAME");
		DataSet ds = onlineDao.query(pset);
		for(int i=0;i<ds.getCount();i++){
			SomChange somChangeOnline = (SomChange)ds.getRecord(i).toBean(SomChange.class);
			String changeItem = somChangeOnline.getChangeItem();
			ParameterSet organPset = new ParameterSet();
			organPset.setParameter("CN_NAME", cnName);
			organPset.setParameter("SORG_STATUS", "22");
			organPset.setParameter("SORG_TYPE", "S");
			DataSet organDs = organDao.query(organPset);
			SomOrgan somOrgan = (SomOrgan)organDs.getRecord(0).toBean(SomOrgan.class);
			String changeBefore = "";
			changeBefore = buildBeforeInfoGroup(somOrgan,changeItem);
			somChangeOnline.setChangeBefore(changeBefore);
			returnDs.addRecord(somChangeOnline);
		}
		
		return returnDs;
	}
	
	public DataSet queryAndBuildGroupBranch() {
		DataSet returnDs = new DataSet();
		ParameterSet pset = getParameterSet();
		String taskCode = (String) pset.getParameter("TASK_CODE");
		String cnName = (String) pset.getParameter("CN_NAME");
		pset.remove("CN_NAME");
		DataSet ds = onlineDao.query(pset);
		for(int i=0;i<ds.getCount();i++){
			SomChange somChangeOnline = (SomChange)ds.getRecord(i).toBean(SomChange.class);
			String changeItem = somChangeOnline.getChangeItem();
			ParameterSet organPset = new ParameterSet();
			organPset.setParameter("CN_NAME", cnName);
			organPset.setParameter("SORG_STATUS", "22");
			organPset.setParameter("SORG_TYPE", "S");
			organPset.setParameter("IF_BRANCH", "1");
			DataSet organDs = organDao.query(organPset);
			SomOrgan somOrgan = (SomOrgan)organDs.getRecord(0).toBean(SomOrgan.class);
			String changeBefore = "";
			changeBefore = buildBeforeInfoGroupBranch(somOrgan,changeItem);
			somChangeOnline.setChangeBefore(changeBefore);
			returnDs.addRecord(somChangeOnline);
		}
		
		return returnDs;
	}

	public DataSet queryAndBuildUngov() {
		DataSet returnDs = new DataSet();
		ParameterSet pset = getParameterSet();
		String taskCode = (String) pset.getParameter("TASK_CODE");
		String cnName = (String) pset.getParameter("CN_NAME");
		pset.remove("CN_NAME");
		DataSet ds = onlineDao.query(pset);
		for(int i=0;i<ds.getCount();i++){
			SomChange somChangeOnline = (SomChange)ds.getRecord(i).toBean(SomChange.class);
			String changeItem = somChangeOnline.getChangeItem();
			ParameterSet organPset = new ParameterSet();
			organPset.setParameter("CN_NAME", cnName);
			organPset.setParameter("SORG_STATUS", "22");
			organPset.setParameter("SORG_TYPE", "M");
			DataSet organDs = organDao.query(organPset);
			SomOrgan somOrgan = (SomOrgan)organDs.getRecord(0).toBean(SomOrgan.class);
			String changeBefore = "";
			changeBefore = buildBeforeInfoUngov(somOrgan,changeItem);
			somChangeOnline.setChangeBefore(changeBefore);
			returnDs.addRecord(somChangeOnline);
		}
		
		return returnDs;
	}
	public DataSet queryAndBuildFund() {
		DataSet returnDs = new DataSet();
		ParameterSet pset = getParameterSet();
		String taskCode = (String) pset.getParameter("TASK_CODE");
		String cnName = (String) pset.getParameter("CN_NAME");
		pset.remove("CN_NAME");
		DataSet ds = onlineDao.query(pset);
		for(int i=0;i<ds.getCount();i++){
			SomChange somChangeOnline = (SomChange)ds.getRecord(i).toBean(SomChange.class);
			String changeItem = somChangeOnline.getChangeItem();
			ParameterSet organPset = new ParameterSet();
			organPset.setParameter("CN_NAME", cnName);
			organPset.setParameter("SORG_STATUS", "22");
			organPset.setParameter("SORG_TYPE", "J");
			DataSet organDs = organDao.query(organPset);
			SomOrgan somOrgan = (SomOrgan)organDs.getRecord(0).toBean(SomOrgan.class);
			String changeBefore = "";
			changeBefore = buildBeforeInfoFund(somOrgan,changeItem);
			somChangeOnline.setChangeBefore(changeBefore);
			returnDs.addRecord(somChangeOnline);
		}
		
		return returnDs;
	}
	public DataSet queryAndBuildFundBranch() {
		DataSet returnDs = new DataSet();
		ParameterSet pset = getParameterSet();
		String taskCode = (String) pset.getParameter("TASK_CODE");
		String cnName = (String) pset.getParameter("CN_NAME");
		pset.remove("CN_NAME");
		DataSet ds = onlineDao.query(pset);
		for(int i=0;i<ds.getCount();i++){
			SomChange somChangeOnline = (SomChange)ds.getRecord(i).toBean(SomChange.class);
			String changeItem = somChangeOnline.getChangeItem();
			ParameterSet organPset = new ParameterSet();
			organPset.setParameter("CN_NAME", cnName);
			organPset.setParameter("SORG_STATUS", "22");
			organPset.setParameter("SORG_TYPE", "J");
			organPset.setParameter("IF_BRANCH", "1");
			DataSet organDs = organDao.query(organPset);
			SomOrgan somOrgan = (SomOrgan)organDs.getRecord(0).toBean(SomOrgan.class);
			String changeBefore = "";
			changeBefore = buildBeforeInfoFundBranch(somOrgan,changeItem);
			somChangeOnline.setChangeBefore(changeBefore);
			returnDs.addRecord(somChangeOnline);
		}
		
		return returnDs;
	}
	
	private String buildBeforeInfoGroup(SomOrgan somOrgan,String changeItem){
		String changeBefore = "";
		if(changeItem.equals("0")){
			changeBefore = StrUtil.n2b(somOrgan.getCnName())+";"+StrUtil.n2b(somOrgan.getSorgKind())+";"+StrUtil.n2b(somOrgan.getBusScope());
		}
		if(changeItem.equals("1")){
			changeBefore = StrUtil.n2b(somOrgan.getResideSource())+";"+StrUtil.n2b(somOrgan.getResidence())+";"+StrUtil.n2b(somOrgan.getHousingOrgan())+";";
			if(somOrgan.getHousingArea() == null){
				changeBefore += "";
			}else{
				changeBefore +=somOrgan.getHousingArea();
			}
			changeBefore += ";"+StrUtil.n2b(somOrgan.getLeasePeriod());
		}
		if(changeItem.equals("2")){
			changeBefore = StrUtil.n2b(somOrgan.getLegalPeople());
		}
		if(changeItem.equals("3")){
			changeBefore = StrUtil.n2b(somOrgan.getBusiness());
		}
		if(changeItem.equals("4")){
			changeBefore = StrUtil.n2b(somOrgan.getRegMon())+";"+StrUtil.n2b(somOrgan.getMoneySource());
		}
		if(changeItem.equals("5")){
			changeBefore = StrUtil.n2b(somOrgan.getBorgName());
		}
		return changeBefore;
	}
	
	private String buildBeforeInfoGroupBranch(SomOrgan somOrgan,String changeItem){
		String changeBefore = "";
		if(changeItem.equals("0")){
			changeBefore = StrUtil.n2b(somOrgan.getCnName())+";"+StrUtil.n2b(somOrgan.getSorgKind())+";"+StrUtil.n2b(somOrgan.getBusScope());
		}
		if(changeItem.equals("1")){
			changeBefore = StrUtil.n2b(somOrgan.getResideSource())+";"+StrUtil.n2b(somOrgan.getResidence())+";"+StrUtil.n2b(somOrgan.getHousingOrgan())+";";
			if(somOrgan.getHousingArea() == null){
				changeBefore += "";
			}else{
				changeBefore +=somOrgan.getHousingArea();
			}
			changeBefore += ";"+StrUtil.n2b(somOrgan.getLeasePeriod());
		}
		if(changeItem.equals("2")){
			changeBefore = StrUtil.n2b(somOrgan.getBranchCharger());
		}
		if(changeItem.equals("3")){
			changeBefore = StrUtil.n2b(somOrgan.getBusiness());
		}
		if(changeItem.equals("4")){
			//changeBefore = StrUtil.n2b(somOrgan.getRegMon())+";"+StrUtil.n2b(somOrgan.getMoneySource());
		}
		if(changeItem.equals("5")){
			changeBefore = StrUtil.n2b(somOrgan.getBorgName());
		}
		return changeBefore;
	}
	
	private String buildBeforeInfoUngov(SomOrgan somOrgan,String changeItem){
		String changeBefore = "";
		if(changeItem.equals("0")){
			changeBefore = StrUtil.n2b(somOrgan.getCnName())+";"+StrUtil.n2b(somOrgan.getSorgKind())+";"+StrUtil.n2b(somOrgan.getBusScope());
		}
		if(changeItem.equals("1")){
			changeBefore = StrUtil.n2b(somOrgan.getResideSource())+";"+StrUtil.n2b(somOrgan.getResidence())+";"+StrUtil.n2b(somOrgan.getHousingOrgan())+";";
			if(somOrgan.getHousingArea() == null){
				changeBefore += "";
			}else{
				changeBefore +=somOrgan.getHousingArea();
			}
			changeBefore += ";"+StrUtil.n2b(somOrgan.getLeasePeriod());
		}
		if(changeItem.equals("2")){
			changeBefore = StrUtil.n2b(somOrgan.getLegalPeople());
		}
		if(changeItem.equals("3")){
			changeBefore = StrUtil.n2b(somOrgan.getBusiness());
		}
		if(changeItem.equals("4")){
			changeBefore = StrUtil.n2b(somOrgan.getRegMon())+";"+StrUtil.n2b(somOrgan.getMoneySource());
		}
		if(changeItem.equals("5")){
			changeBefore = StrUtil.n2b(somOrgan.getBorgName());
		}
		return changeBefore;
	}
	private String buildBeforeInfoFund(SomOrgan somOrgan, String changeItem) {
		String changeBefore = "";
		if(changeItem.equals("0")){
			changeBefore = StrUtil.n2b(somOrgan.getCnName());
		}
		if(changeItem.equals("1")){
			changeBefore =StrUtil.n2b(somOrgan.getResidence());
		}
		if(changeItem.equals("2")){
			changeBefore = StrUtil.n2b(somOrgan.getLegalPeople());
		}
		if(changeItem.equals("3")){
			changeBefore = StrUtil.n2b(somOrgan.getBusiness());
		}
		if(changeItem.equals("4")){
			changeBefore = StrUtil.n2b(somOrgan.getRegMon())+";"+StrUtil.n2b(somOrgan.getMoneySource());
		}
		if(changeItem.equals("5")){
			changeBefore = StrUtil.n2b(somOrgan.getPurpose());
		}
		if(changeItem.equals("6")){
			changeBefore = StrUtil.n2b(somOrgan.getSorgKind());
		}
		return changeBefore;
	}

	private String buildBeforeInfoFundBranch(SomOrgan somOrgan,String changeItem){
		String changeBefore = "";
		if(changeItem.equals("0")){
			changeBefore = StrUtil.n2b(somOrgan.getCnName())+";"+StrUtil.n2b(somOrgan.getSorgKind())+";"+StrUtil.n2b(somOrgan.getBusScope());
		}
		if(changeItem.equals("1")){
//			changeBefore = StrUtil.n2b(somOrgan.getResideSource())+";"+StrUtil.n2b(somOrgan.getResidence())+";"+StrUtil.n2b(somOrgan.getHousingOrgan())+";";
//			if(somOrgan.getHousingArea() == null){
//				changeBefore += "";
//			}else{
//				changeBefore +=somOrgan.getHousingArea();
//			}
			changeBefore =StrUtil.n2b(somOrgan.getResidence());
		}
		if(changeItem.equals("2")){
			changeBefore = StrUtil.n2b(somOrgan.getBranchCharger());
		}
		if(changeItem.equals("3")){
			changeBefore = StrUtil.n2b(somOrgan.getBusiness());
		}
		if(changeItem.equals("4")){
			//changeBefore = StrUtil.n2b(somOrgan.getRegMon())+";"+StrUtil.n2b(somOrgan.getMoneySource());
		}
		if(changeItem.equals("5")){
			changeBefore = StrUtil.n2b(somOrgan.getBorgName());
		}
		return changeBefore;
	}
}
