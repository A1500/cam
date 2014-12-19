package com.inspur.cams.prs.prsretiredsoldiers.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.diccity.dao.jdbc.DicCityDao;
import com.inspur.cams.comm.diccity.data.DicCity;
import com.inspur.cams.prs.prsretiredsoldiers.domain.IPrsRetiredSoldiersDomain;

/**
 * @title:PrsRetiredSoldiersQueryCommand
 * @description:
 * @author:
 * @since:2011-08-18
 * @version:1.0
*/
public class PrsRetiredSoldiersQueryCommand extends BaseQueryCommand{

	private IPrsRetiredSoldiersDomain prsRetiredSoldiersDomain = ScaComponentFactory
	.getService(IPrsRetiredSoldiersDomain.class,
			"PrsRetiredSoldiersDomain.PrsRetiredSoldiersService");

	public DataSet querySoldierById(){
		ParameterSet pset = getParameterSet();
		DataSet ds = prsRetiredSoldiersDomain.querySoldierById(pset);
		ds.addField("domicileName");
		DicCityDao dao = (DicCityDao) DaoFactory
		.getDao("com.inspur.cams.comm.diccity.dao.jdbc.DicCityDao");
		if(ds.getCount()>0){
			Record soldierRecord = ds.getRecord(0);
			String domicileName=null;
			String domicileCode = soldierRecord.get("wherePlacemen")==null?null:soldierRecord.get("wherePlacemen").toString();
			if(domicileCode!=null ){
				pset.clear();
				pset.setParameter("ID", domicileCode);
				DataSet domicileCodeDataSet = dao.query(pset);
				if(domicileCodeDataSet.getCount()>0){
				    Record domicileCodeRecord = domicileCodeDataSet.getRecord(0);
				     domicileName = domicileCodeRecord.get("fullName").toString();
				    soldierRecord.set("domicileName",domicileName);
				}
			}
		}
		return ds;
	}
	
	@SuppressWarnings("unchecked")
	public DataSet querySoldiers() {

		ParameterSet pset = getParameterSet();
		DataSet soldierDataSet= prsRetiredSoldiersDomain.querySoldiers(pset);
		List<Record> list = new ArrayList<Record>();
		soldierDataSet.addField("domicileName");
		soldierDataSet.addField("enlistPlaceName");
		EntityDao<DicCity> dao = (EntityDao<DicCity>) DaoFactory
		.getDao("com.inspur.cams.comm.diccity.dao.jdbc.DicCityDao");


		for(int i=0;i<soldierDataSet.getCount();i++){
			Record soldierRecord = soldierDataSet.getRecord(i);
			String domicileName=null;
			//  String enlistPlaceName=null;
			//获取domicileName
			String domicileCode = soldierRecord.get("WHEREPLACEMENT")==null?null:soldierRecord.get("WHEREPLACEMENT").toString();
			if(domicileCode!=null ){
				pset.clear();
				pset.setParameter("ID", domicileCode);
				DataSet domicileCodeDataSet = dao.query(pset);
				if(domicileCodeDataSet.getCount()>0){
				    Record domicileCodeRecord = domicileCodeDataSet.getRecord(0);
				     domicileName = domicileCodeRecord.get("fullName").toString();
				    soldierRecord.set("domicileName",domicileName);
				}
			}
			list.add(soldierRecord);
		}

		DataSet ds = new DataSet();
		ds.getRecordSet().addAll(list);
		ds.setTotalCount(soldierDataSet.getTotalCount());
		return ds;
	}
	@SuppressWarnings("unchecked")
	public DataSet querySoldier() {
		ParameterSet pset = getParameterSet();
		DataSet soldierDataSet= prsRetiredSoldiersDomain.querySoldier(pset);
		List<Record> list = new ArrayList<Record>();
		soldierDataSet.addField("domicileName");
		EntityDao<DicCity> dao = (EntityDao<DicCity>) DaoFactory
		.getDao("com.inspur.cams.comm.diccity.dao.jdbc.DicCityDao");
		for(int i=0;i<soldierDataSet.getCount();i++){
			Record soldierRecord = soldierDataSet.getRecord(i);

			//获取domicileName
			String domicileCode = soldierRecord.get("WHEREPLACEMENT")==null?null:soldierRecord.get("WHEREPLACEMENT").toString();
			if(domicileCode!=null ){
				pset.clear();
				pset.setParameter("ID", domicileCode);
				DataSet domicileCodeDataSet = dao.query(pset);
				if(domicileCodeDataSet.getCount()>0){
				    Record domicileCodeRecord = domicileCodeDataSet.getRecord(0);
				    String domicileName = domicileCodeRecord.get("fullName").toString();
				    soldierRecord.set("domicileName",domicileName);
				}
			}
			list.add(soldierRecord);
		}

		DataSet ds = new DataSet();
		ds.getRecordSet().addAll(list);
		ds.setTotalCount(soldierDataSet.getTotalCount());
		return ds;
	}
	
	public DataSet queryPeopleNum(){
		ParameterSet pset = getParameterSet();
		DataSet ds = prsRetiredSoldiersDomain.queryPeopleNum(pset);
		return ds;
	}
	
	@SuppressWarnings("unchecked")
	public DataSet querySoldierss() {

		ParameterSet pset = getParameterSet();
		DataSet soldierDataSet= prsRetiredSoldiersDomain.querySoldierss(pset);
		List<Record> list = new ArrayList<Record>();
		soldierDataSet.addField("domicileName");
		EntityDao<DicCity> dao = (EntityDao<DicCity>) DaoFactory
		.getDao("com.inspur.cams.comm.diccity.dao.jdbc.DicCityDao");


		for(int i=0;i<soldierDataSet.getCount();i++){
			Record soldierRecord = soldierDataSet.getRecord(i);
			String domicileName=null;
			//获取domicileName
			  String domicileCode = soldierRecord.get("WHEREPLACEMENT")==null?null:soldierRecord.get("WHEREPLACEMENT").toString();
			if(domicileCode!=null ){
				pset.clear();
				pset.setParameter("ID", domicileCode);
				DataSet domicileCodeDataSet = dao.query(pset);
				if(domicileCodeDataSet.getCount()>0){
				    Record domicileCodeRecord = domicileCodeDataSet.getRecord(0);
				     domicileName = domicileCodeRecord.get("fullName").toString();
				    soldierRecord.set("domicileName",domicileName);
				}
			}
			list.add(soldierRecord);
		}

		DataSet ds = new DataSet();
		ds.getRecordSet().addAll(list);
		ds.setTotalCount(soldierDataSet.getTotalCount());
		return ds;
	}

	@SuppressWarnings("unchecked")
    public DataSet queryBatchSoldiers(){
	    ParameterSet pset = getParameterSet();
	    DataSet soldierDataSet= prsRetiredSoldiersDomain.queryBatchSoldiers(pset);
        List<Record> list = new ArrayList<Record>();
        soldierDataSet.addField("domicileName");
        String domicileName=null;
        EntityDao<DicCity> dao = (EntityDao<DicCity>) DaoFactory
        .getDao("com.inspur.cams.comm.diccity.dao.jdbc.DicCityDao");


        for(int i=0;i<soldierDataSet.getCount();i++){
            Record soldierRecord = soldierDataSet.getRecord(i);
            String domicileCode = soldierRecord.get("WHEREPLACEMENT")==null?null:soldierRecord.get("WHEREPLACEMENT").toString();
			if(domicileCode!=null ){
				pset.clear();
				pset.setParameter("ID", domicileCode);
				DataSet domicileCodeDataSet = dao.query(pset);
				if(domicileCodeDataSet.getCount()>0){
				    Record domicileCodeRecord = domicileCodeDataSet.getRecord(0);
				    if ("00999000".equals(domicileCode.substring(4, 12))){
				    	 domicileName = domicileCodeRecord.get("name").toString();
				    }else  {
				     domicileName = domicileCodeRecord.get("fullName").toString();
				    }
				    soldierRecord.set("domicileName",domicileName);
				}
			}
            list.add(soldierRecord);
        }

        DataSet ds = new DataSet();
        ds.getRecordSet().addAll(list);
        ds.setTotalCount(soldierDataSet.getTotalCount());
        return ds;
	}

    public DataSet queryDisabilitySoldiers(){

	    ParameterSet pset = getParameterSet();
	    DataSet soldierDataSet = prsRetiredSoldiersDomain.queryDisabilitySoldiers(pset);
        return soldierDataSet;

	}
	public DataSet queryMilitarySoldiers(){
		 ParameterSet pset = getParameterSet();
		    DataSet soldierDataSet = prsRetiredSoldiersDomain.queryMilitarySoldiers(pset);
	        return soldierDataSet;
	}
	public DataSet queryPlacementSoldiers(){
		ParameterSet pset = getParameterSet();
	    DataSet soldierDataSet = prsRetiredSoldiersDomain.queryPlacementSoldiers(pset);
        return soldierDataSet;
	}

	public DataSet queryTrainingSoldiers(){

		ParameterSet pset = getParameterSet();
	    DataSet soldierDataSet = prsRetiredSoldiersDomain.queryTrainingSoldiers(pset);
        return soldierDataSet;
	}
	
	public DataSet queryDisabilityPlacement(){
		ParameterSet pset = getParameterSet();
	    DataSet soldierDataSet = prsRetiredSoldiersDomain.queryDisabilityPlacement(pset);
        return soldierDataSet;
	}
	/**
	 * 退役士兵安置地明细表查询
	 * @return
	 */
	public DataSet querySoldiersPlacement(){
		ParameterSet pset = getParameterSet();
		DataSet ds = prsRetiredSoldiersDomain.querySoldiersPlacement(pset);
		return ds;
	}
	/**
	 * 退役士兵培训统计表查询
	 * @return
	 */
	public DataSet querySoldiersTraining(){
		ParameterSet pset = getParameterSet();
		DataSet ds = prsRetiredSoldiersDomain.querySoldiersTraining(pset);
		return ds;
	}

}
