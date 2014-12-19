package com.inspur.cams.prs.prsretiredsoldiers.cmd;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import org.loushang.bsp.id.util.MaxValueUtil;
import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.comm.diccity.data.DicCity;
import com.inspur.cams.comm.dicm.IDicDao;
import com.inspur.cams.comm.linuxense.javadbf.DBFException;
import com.inspur.cams.comm.linuxense.javadbf.DBFReader;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.prs.prsawardsmeritorious.dao.PrsAwardsMeritorious;
import com.inspur.cams.prs.prsretiredsoldiers.dao.PrsRetiredSoldiers;
import com.inspur.cams.prs.prsretiredsoldiers.domain.IPrsRetiredSoldiersDomain;
import com.inspur.cams.prs.prssoldiersarmy.dao.PrsSoldiersArmy;

/**
 * @title:PrsRetiredSoldiersCommand
 * @description:
 * @author:
 * @since:2011-08-18
 * @version:1.0
 */
public class PrsRetiredSoldiersCommand extends BaseAjaxCommand {

	private IPrsRetiredSoldiersDomain prsRetiredSoldiersDomain = ScaComponentFactory
			.getService(IPrsRetiredSoldiersDomain.class,
					"PrsRetiredSoldiersDomain.PrsRetiredSoldiersService");

	/**
	 * 保存退役士兵基本信息、部队信息及立功授奖情况到数据库
	 */
	@Trans
	public void saveBaseInfo() {
		// 获取页面提交士兵基本信息
		Record soldierRecord = (Record) getParameter("recordSoldier");
		PrsRetiredSoldiers soldier = (PrsRetiredSoldiers) soldierRecord
				.toBean(PrsRetiredSoldiers.class);
		soldier.setUploadFlag("0");
		if("".equals(soldier.getAllotFlag())||soldier.getAllotFlag()==null){
			soldier.setAllotFlag("1");
		}
		soldier.setFileNum(soldier.getServedMilitaryRegion()+MaxValueUtil.nextStringValue("RETIRED_SOLDIER_FILE_NUM"));
		// 获取页面提交的退役士兵部队信息
		Record armyRecord = (Record) getParameter("recordArmy");
		PrsSoldiersArmy army = (PrsSoldiersArmy) armyRecord
				.toBean(PrsSoldiersArmy.class);
		// 获取页面提交的退役士兵立功授奖情况
		Record[] records = (Record[]) getParameter("records");
		List<PrsAwardsMeritorious> awards = new ArrayList<PrsAwardsMeritorious>();
		if (records != null) {
			for (int i = 0; i < records.length; i++) {
				PrsAwardsMeritorious dataBean = (PrsAwardsMeritorious) records[i]
						.toBean(PrsAwardsMeritorious.class);
				if (("".equals(dataBean.getAwardsType()))
						|| "".equals(dataBean.getAwardsName())) {

				} else {
					dataBean.setAwardsId(IdHelp.getUUID32());
					dataBean.setsoldiersId(soldier.getSoldiersId());
					awards.add(dataBean);
				}
			}
		}

		// 保存以上信息到数据库
		prsRetiredSoldiersDomain.saveBaseInfo(soldier, army, awards);
	}
	public void saveBaseInfou() {
		// 获取页面提交士兵基本信息
		Record soldierRecord = (Record) getParameter("recordSoldier");
		PrsRetiredSoldiers soldier = (PrsRetiredSoldiers) soldierRecord
				.toBean(PrsRetiredSoldiers.class);
		soldier.setUploadFlag("0");
		if("".equals(soldier.getAddress())||soldier.getAllotFlag()==null){
			soldier.setAllotFlag("1");
		}
		soldier.setFileNum(soldier.getServedMilitaryRegion()+MaxValueUtil.nextStringValue("RETIRED_SOLDIER_FILE_NUM"));
		// 获取页面提交的退役士兵部队信息
		Record armyRecord = (Record) getParameter("recordArmy");
		PrsSoldiersArmy army = (PrsSoldiersArmy) armyRecord
				.toBean(PrsSoldiersArmy.class);
		// 获取页面提交的退役士兵立功授奖情况
		Record[] records = (Record[]) getParameter("records");
		List<PrsAwardsMeritorious> awards = new ArrayList<PrsAwardsMeritorious>();
		if (records != null) {
			for (int i = 0; i < records.length; i++) {
				PrsAwardsMeritorious dataBean = (PrsAwardsMeritorious) records[i]
						.toBean(PrsAwardsMeritorious.class);
				if (("".equals(dataBean.getAwardsType()))
						|| "".equals(dataBean.getAwardsName())) {

				} else {
					dataBean.setAwardsId(IdHelp.getUUID32());
					dataBean.setsoldiersId(soldier.getSoldiersId());
					awards.add(dataBean);
				}
			}
		}

		// 保存以上信息到数据库
		prsRetiredSoldiersDomain.saveBaseInfo(soldier, army, awards);
	}
	/**
	 * 更新数据库中退役士兵的基本信息
	 */
	@Trans
	public void updateSoldier() {

		Record soldierRecord = (Record) getParameter("recordSoldier");
		PrsRetiredSoldiers soldier = (PrsRetiredSoldiers) soldierRecord
				.toBean(PrsRetiredSoldiers.class);

		prsRetiredSoldiersDomain.updateSoldier(soldier);
	}

	/**
	 * 保存复员干部的基本信息到数据库
	 */
	@Trans
	public void saveSoldier() {

		Record soldierRecord = (Record) getParameter("recordSoldier");
		PrsRetiredSoldiers soldier = (PrsRetiredSoldiers) soldierRecord
				.toBean(PrsRetiredSoldiers.class);
		soldier.setFileNum(MaxValueUtil.nextStringValue("RETIRED_SOLDIER_FILE_NUM"));

		prsRetiredSoldiersDomain.saveSoldier(soldier);
	}

	/**
	 * 批量删除退役士兵信息（级联）
	 */
	@Trans
	public void delete() {
		String[] delIds = (String[]) getParameter("delIds");
		for (String id : delIds) {
			prsRetiredSoldiersDomain.delete(id);
		}
	}

	/**
	 * 审核退役士兵信息
	 */
	@Trans
	public void approvalSoldiers() {
		String[] ids = (String[]) getParameter("ids");
		for (String id : ids) {
			prsRetiredSoldiersDomain.approval(id);
		}
	}

	/**
	 * 上报未审核退役士兵信息
	 */
	@Trans
	public void sendUpSoldiers() {
		String[] ids = (String[]) getParameter("ids");
		for (String id : ids) {
			prsRetiredSoldiersDomain.sendUp(id);
		}
	}

	/**
	 * 更新退役士兵基本信息
	 */
	@Trans
	public void updateBaseInfo() {
		Record soldierRecord = (Record) getParameter("recordSoldier");
		PrsRetiredSoldiers soldier = (PrsRetiredSoldiers) soldierRecord
				.toBean(PrsRetiredSoldiers.class);
		Record armyRecord = (Record) getParameter("recordArmy");
		PrsSoldiersArmy army = (PrsSoldiersArmy) armyRecord
				.toBean(PrsSoldiersArmy.class);
		Record[] records = (Record[]) getParameter("records");
		List<PrsAwardsMeritorious> awards = new ArrayList<PrsAwardsMeritorious>();
		if (records != null) {
			for (int i = 0; i < records.length; i++) {
				PrsAwardsMeritorious dataBean = (PrsAwardsMeritorious) records[i]
						.toBean(PrsAwardsMeritorious.class);
				dataBean.setAwardsId(IdHelp.getUUID32());
				dataBean.setsoldiersId(soldier.getSoldiersId());
				awards.add(dataBean);
			}
		}
		prsRetiredSoldiersDomain.updateSoldier(soldier);
		prsRetiredSoldiersDomain.updataArmy(army);
		prsRetiredSoldiersDomain.updataAwards(soldier.getSoldiersId(), awards);
	}

	@Trans
	public void updateTrainFlag(){
	    String soldeirId = (String) getParameter("soldierId");
	    prsRetiredSoldiersDomain.updateTrainFlag(soldeirId);
	    
	}
	@Trans
	public void updatePlacementFlag(){
	    String soldierId = (String) getParameter("soldierId");
	    prsRetiredSoldiersDomain.updatePlacementFlag(soldierId);
	    
	}
	@Trans
	public void updateAllotFlag(){
	    String[] soldierIds = (String[]) getParameter("ids");
	    prsRetiredSoldiersDomain.updateAllotFlag(soldierIds);
	}
	@Trans
	public void updateAllotFlagAll(){
	    ParameterSet pset = getParameterSet();
	    pset.setParameter("flag", "1");//是否全部选择的标准
	    DataSet ds = prsRetiredSoldiersDomain.queryBatchSoldiers(pset);
	    List<String> id = new ArrayList<String>();
	    for(int i=0;i<ds.getCount();i++){
	        String flag = (String) ds.getRecord(i).get("FLAG");
	        if("1".equals(flag)){
	        	id.add((String) ds.getRecord(i).get("ID"));
	        }
	    }
	    String[] ids = id.toArray(new String[id.size()]);
	    prsRetiredSoldiersDomain.updateAllotFlag(ids);
	}
	@Trans
	public void upload(){
		String filename = (String) getParameter("filename");
		int count = 0;
		if(!((filename.endsWith(".dbf"))||(filename.endsWith(".DBF")))){
			throw new RuntimeException("文件类型不正确！");
		}
		 try {
		      InputStream inputStream  = new FileInputStream(filename); 
		      DBFReader reader = new DBFReader( inputStream); 
		      Object []rowObjects;
		      while( (rowObjects = reader.nextRecord()) != null) {
		    	  PrsRetiredSoldiers soldier = new PrsRetiredSoldiers();
		    	  count ++;
		    	  soldier.setName((String)rowObjects[1]);//名字
		    	  soldier.setServedMilitaryRegion(getMilitaryRegion(rowObjects[2]));//所在军区
		    	  soldier.setWherePlacemen(getDicCityID(rowObjects[9],rowObjects[10]));//安置地
		    	  soldier.setRetiredTime((Calendar.getInstance().get(Calendar.YEAR)-1 )+"-12-01");
		    	  soldier.setEnlistPlace(rowObjects[7].toString().trim()+rowObjects[8].toString().trim());//入伍地
		    	  soldier.setSpouseLocation(rowObjects[11].toString().trim()+rowObjects[12].toString().trim());
		    	  soldier.setEnlistTime(getEnlistTime(rowObjects[6]));//入伍时间
		    	  soldier.setServedArmy(rowObjects[3].toString().trim());//部队
		    	  soldier.setSpecialty(rowObjects[5].toString().trim());//专业
		    	  soldier.setContent(getContent(rowObjects[16]));//备注
		    	  soldier.setTransFile(rowObjects[14].toString().trim());//移交材料
		    	  soldier.setPlacemenRenson("2");//安置理由
		    	  soldier.setSoldiersId(IdHelp.getUUID32());
		    	  soldier.setFileNum(MaxValueUtil.nextStringValue("RETIRED_SOLDIER_FILE_NUM"));
		    	  soldier.setRetiredSoldierType("3");
		    	  soldier.setAllotFlag("0");
		    	  soldier.setEmplacementflag("0");
		    	  soldier.setTrainingflag("0");
		    	  soldier.setFlag(getFlag(rowObjects[15]));
		    	  soldier.setUploadFlag("1");
		    	  soldier.setNaton("01");
		    	  soldier.setSex("1");
		    	  save(soldier);
		      }
		      inputStream.close();
		    }
		    catch( DBFException e) {
		      e.getMessage();
		    }
		    catch( IOException e) {
		      e.getMessage();
		    }
		    setReturn("count", count);
	}


	private String getContent(Object object) {
		if(object==null||"null".equalsIgnoreCase((String) object))	{
			return "";
		}else {
			return object.toString().trim();
		}
	}
	private String getFlag(Object object) {
		if(object==null) return "1";
		if(!"false".equalsIgnoreCase(object.toString().trim())){
			return "2";
		}
		return "1";
	}
	@Trans
	private void save(PrsRetiredSoldiers soldier) {
		PrsSoldiersArmy army = new PrsSoldiersArmy();
		army.setArmyId(IdHelp.getUUID32());
		army.setSoldiersId(soldier.getSoldiersId());
		List<PrsAwardsMeritorious> awards = new ArrayList<PrsAwardsMeritorious>();
		prsRetiredSoldiersDomain.saveBaseInfo(soldier, army, awards);
	}

	private String getEnlistTime(Object object) {
		if(object==null) return null;
			String temptime = object.toString().trim();
			String[] time = temptime.split("\\.");
			if(time.length==2){
				return time[0]+"-"+time[1]+"-01";
			}
		return null;
	}

	@SuppressWarnings("unchecked")
	@Trans
	private String getDicCityID(Object shi,Object xian) {
		if(shi==null||xian==null) return null;
		ParameterSet pset = new ParameterSet();
		EntityDao<DicCity> dao = (EntityDao<DicCity>) DaoFactory
		.getDao("com.inspur.cams.comm.diccity.dao.jdbc.DicCityDao");
		String name =shi.toString().trim()+xian.toString().trim();
		if("".equals(name))return null;
		pset.setParameter("FULL_NAME@=", name);
		DataSet dataSet = dao.query(pset);
		if(dataSet.getCount()>0){
			return (String) dataSet.getRecord(0).get("id");
		}
		String tyrname =shi.toString().trim();
		if("".equals(tyrname))return null;
		pset.clear();
		pset.setParameter("NAME", tyrname);
		dataSet = dao.query(pset);
		if(dataSet.getCount()>0){
			return (String) dataSet.getRecord(0).get("id");
		}
		return "";
	}
	@Trans
	private String getMilitaryRegion(Object object) {
		if(object==null) return null;
		ParameterSet pset = new ParameterSet();
		pset.setParameter("dic","DIC_MILITARY_REGION_CODE");
		pset.setParameter("value", "CODE");
		pset.setParameter("text", "NAME");
		String filterSql = " NAME = '" +object.toString().trim()+"' ";
		pset.setParameter("filterSql", filterSql);
		IDicDao dao = (IDicDao) DaoFactory.getDao("com.inspur.cams.comm.dicm.DicDao");
		DataSet ds = dao.getDicMapList(pset);
		if(ds.getCount()>0){
			String re = (String) ds.getRecord(0).get("value"); 
			return re;
		}
		return null;
	}
	
}
