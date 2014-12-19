package com.inspur.cams.bpt.manage.cmd;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.bpt.base.dao.jdbc.BptCompulsoryDao;
import com.inspur.cams.bpt.capital.dao.jdbc.BptCapitalstaDao;
import com.inspur.cams.bpt.capital.dao.jdbc.BptCompulsoryDetailsDao;
import com.inspur.cams.bpt.capital.domain.IBptCompulsoryDetailsDomain;
import com.inspur.cams.comm.diccity.dao.jdbc.DicCityDao;
/**
 * @title:义务兵优待金月（标准）发放名册和非义务兵优待金月（标准）发放名册查询
 */
public class BptCompulsoryDetailsQueryCommand extends BaseQueryCommand{
	/**
	 * 获得优待金发放服务接口
	 */
	private IBptCompulsoryDetailsDomain compulDetailService = ScaComponentFactory.getService(IBptCompulsoryDetailsDomain.class,
	"bptCompulsoryDetailsDomain/bptCompulsoryDetailsDomain");
	
	private BptCapitalstaDao compulStaDao = (BptCapitalstaDao) DaoFactory.getDao("com.inspur.cams.bpt.capital.dao.jdbc.BptCapitalstaDao");
	
	/**
	 * 获得义务兵家庭信息dao
	 */
	private BptCompulsoryDao dao = (BptCompulsoryDao) DaoFactory.getDao("com.inspur.cams.bpt.base.dao.jdbc.BptCompulsoryDao");
	
	/**
	 * 查询义务兵优待金发放列表
	 */
	public DataSet queryCompulsoryGrantList(){
		ParameterSet pset = getParameterSet();
		return compulDetailService.queryCompulsoryGrantList(pset);
	}
	
	/**
	 * 查询义务兵优待金修改时的数据集
	 */
	public DataSet queryCompulGrantUpdate(){
		ParameterSet pset = new ParameterSet();
		String regDetailId = getParameter("regDetailId").toString();
		String peopleId = getParameter("peopleId").toString();
		pset.setParameter("REG_DETAIL_ID",regDetailId);
		Record compulDetailRD = compulDetailService.queryCompulDetail(pset).getRecord(0);
		
		pset.clear();
		pset.setParameter("ID",peopleId);
		Record compulsoryRD = dao.query(pset).getRecord(0);
		String domicileCode = compulsoryRD.get("domicileCode").toString();
		
		DicCityDao cityDao = (DicCityDao) DaoFactory.getDao("com.inspur.cams.comm.diccity.dao.jdbc.DicCityDao");
		pset.clear();
		pset.setParameter("ID", domicileCode);
		DataSet domicileCodeDataSet = cityDao.query(pset);
		Record domicileCodeRecord = domicileCodeDataSet.getRecord(0);
		String domicileName = domicileCodeRecord.get("name").toString();
		compulDetailRD.set("domicileName", domicileName);
		compulDetailRD.set("name", compulsoryRD.get("name").toString());
		compulDetailRD.set("sex", compulsoryRD.get("sex").toString());
		compulDetailRD.set("idCard", compulsoryRD.get("idCard").toString());
		compulDetailRD.set("birthday", compulsoryRD.get("birthday").toString());
		compulDetailRD.set("nation", compulsoryRD.get("nation").toString());
		compulDetailRD.set("specialSettingNo", compulsoryRD.get("specialSettingNo").toString());
		compulDetailRD.set("conscriptDate", compulsoryRD.get("conscriptDate").toString());
		compulDetailRD.set("composedPortrait", compulsoryRD.get("composedPortrait").toString());
		compulDetailRD.set("domicileType", compulsoryRD.get("domicileType").toString());
		if(compulsoryRD.get("telContact")!=null&&!compulsoryRD.get("telContact").equals("")){
			compulDetailRD.set("telContact", compulsoryRD.get("telContact").toString());
		}
		if(compulsoryRD.get("postcode")!=null&&!compulsoryRD.get("postcode").equals("")){
			compulDetailRD.set("postcode", compulsoryRD.get("postcode").toString());
		}
		if(compulsoryRD.get("postcode")!=null&&!compulsoryRD.get("postcode").equals("")){
			compulDetailRD.set("postcode", compulsoryRD.get("postcode").toString());
		}
		if(compulsoryRD.get("domicileName")!=null&&!compulsoryRD.get("domicileName").equals("")){
			compulDetailRD.set("domicileName", compulsoryRD.get("domicileName").toString());
		}
		if(compulsoryRD.get("address")!=null&&!compulsoryRD.get("address").equals("")){
			compulDetailRD.set("address", compulsoryRD.get("address").toString());
		}
		if(compulsoryRD.get("fatherName")!=null&&!compulsoryRD.get("fatherName").equals("")){
			compulDetailRD.set("fatherName", compulsoryRD.get("fatherName").toString());
		}
		if(compulsoryRD.get("fatherUnit")!=null&&!compulsoryRD.get("fatherUnit").equals("")){
			compulDetailRD.set("fatherUnit", compulsoryRD.get("fatherUnit").toString());
		}
		if(compulsoryRD.get("fatherContact")!=null&&!compulsoryRD.get("fatherContact").equals("")){
			compulDetailRD.set("fatherContact", compulsoryRD.get("fatherContact").toString());
		}
		if(compulsoryRD.get("motherName")!=null&&!compulsoryRD.get("motherName").equals("")){
			compulDetailRD.set("motherName", compulsoryRD.get("motherName").toString());
		}
		if(compulsoryRD.get("motherUnit")!=null&&!compulsoryRD.get("motherUnit").equals("")){
			compulDetailRD.set("motherUnit", compulsoryRD.get("motherUnit").toString());
		}
		if(compulsoryRD.get("motherContact")!=null&&!compulsoryRD.get("motherContact").equals("")){
			compulDetailRD.set("motherContact", compulsoryRD.get("motherContact").toString());
		}
		if(compulsoryRD.get("bank")!=null&&!compulsoryRD.get("bank").equals("")){
			compulDetailRD.set("bank", compulsoryRD.get("bank").toString());
		}
		if(compulsoryRD.get("accountCode")!=null&&!compulsoryRD.get("accountCode").equals("")){
			compulDetailRD.set("accountCode", compulsoryRD.get("accountCode").toString());
		}
		return new DataSet(compulDetailRD);
	}
	
	/**
	 * 查询添加义务兵优待金发放时的数据集 
	 */
	public DataSet queryCompulGrantAdd(){
		ParameterSet pset = new ParameterSet();
		String organCode = getParameter("organCode").toString();
		if(getParameter("idCard")==null){
			pset.setParameter("ID",getParameter("peopleId").toString());
		}else{
			pset.setParameter("ID_CARD",getParameter("idCard").toString());
		}
		//获取义务兵信息
		if(dao.query(pset).getCount()!=0){
			Record compulsoryRD = dao.query(pset).getRecord(0);
			String peopleId = compulsoryRD.get("id").toString();
			String domicileCode = compulsoryRD.get("domicileCode").toString();
			String composedPortrait = compulsoryRD.get("composedPortrait").toString();
			String domicileType = compulsoryRD.get("domicileType").toString();
			//获取发放次数
			pset.clear();
			pset.setParameter("PEOPLE_ID", peopleId);
			DataSet compulDetailDs = compulDetailService.queryCompulDetail(pset);
			if(compulDetailDs.getCount()==0){
				compulsoryRD.set("grantNumber", "0");
			}else{
				compulsoryRD.set("grantNumber", String.valueOf(compulDetailDs.getCount()));
			}
			//获取domicileName
			DicCityDao dao = (DicCityDao)DaoFactory.getDao("com.inspur.cams.comm.diccity.dao.jdbc.DicCityDao");
			pset.clear();
			pset.setParameter("ID", domicileCode);
			String domicileName = dao.query(pset).getRecord(0).get("name").toString();
			compulsoryRD.set("domicileName",domicileName);
			SimpleDateFormat dateformat1=new SimpleDateFormat("yyyy");
			SimpleDateFormat dateformat2=new SimpleDateFormat("yyyy-MM-dd");
			String belongYear = dateformat1.format(new Date());
			String grantDate = dateformat2.format(new Date());
			compulsoryRD.set("belongYear",belongYear);
			compulsoryRD.set("grantDate",grantDate);
			//获取金额和标准
			pset.clear();
			pset.setParameter("SUBSTR(START_DATE,1,4)", belongYear);
			pset.setParameter("STANDARDS_COUNTIES", organCode);
			pset.setParameter("IN_TIBET", composedPortrait);
			pset.setParameter("DOMICILE_TYPE", domicileType);
			Record compulsorySta = compulStaDao.query(pset).getRecord(0);
			String newmoonStandards = compulsorySta.get("newmoonStandards").toString();
			String inTibetAdditional = compulsorySta.get("inTibetAdditional").toString();
			compulsoryRD.set("grantMon", newmoonStandards);
			compulsoryRD.set("inTibetAdditional",inTibetAdditional);
			compulsoryRD.set("total", String.valueOf(Double.parseDouble(newmoonStandards)+Double.parseDouble(inTibetAdditional)));
			DataSet resultDS = new DataSet(compulsoryRD);
			return resultDS;
		}else{
			DataSet resultDS = new DataSet();
			return resultDS;
		}
	}
	
	/**
	 * 查询非义务兵其他优抚对象修改时的记录集
	 */
	public DataSet queryCompulsoryUpdate(){
		ParameterSet pset = getParameterSet();
		pset.setParameter("sort", "DOMICILE_CODE,NAME");
		return compulDetailService.queryCompulsoryUpdate(pset);
	}
	
	/**
	 * 查询导出数据
	 */
	public DataSet queryCompulExportData(){
		BptCompulsoryDetailsDao compulsoryDetailsDao = (BptCompulsoryDetailsDao) DaoFactory.getDao("com.inspur.cams.bpt.capital.dao.jdbc.BptCompulsoryDetailsDao");
		ParameterSet pset = getParameterSet();
		DataSet ds = compulsoryDetailsDao.queryCompulExportData(pset);
		return ds;
	}
}
