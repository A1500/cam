package com.inspur.cams.bpt.manage.cmd;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.sca.transaction.Trans;
import com.inspur.cams.bpt.capital.dao.jdbc.BptCapitalDetailDao;
import com.inspur.cams.bpt.capital.dao.jdbc.BptCapitalSummaryDao;
import com.inspur.cams.bpt.capital.data.BptCapitalDetail;
import com.inspur.cams.bpt.capital.data.BptCapitalSummary;
import com.inspur.cams.bpt.capital.domain.IBptCapialDetailDomain;
import com.inspur.cams.bpt.capital.domain.IBptCapitalSummaryDomain;
import com.inspur.cams.bpt.manage.domain.IBptGroupDomain;
import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;

/**
 * @title:BptCapitalDetailCommand
 * @description: 资金发放
 * @author:
 * @since:2011-05-28
 * @version:1.0
 */
public class BptCapitalDetailCommand extends BaseAjaxCommand {
	private BptCapitalDetailDao detailDao = (BptCapitalDetailDao) DaoFactory
			.getDao("com.inspur.cams.bpt.capital.dao.jdbc.BptCapitalDetailDao");

	private BptCapitalSummaryDao sumarydao = (BptCapitalSummaryDao) DaoFactory
			.getDao("com.inspur.cams.bpt.capital.dao.jdbc.BptCapitalSummaryDao");
    
	private IBptGroupDomain service = ScaComponentFactory.getService(IBptGroupDomain.class,"bptGroupDomain/bptGroupDomain");
	
	private IBptCapialDetailDomain capitalDetailDomainService = ScaComponentFactory.getService(IBptCapialDetailDomain.class,"bptCapialDetailDomain/bptCapialDetailDomain");
	
	private IBptCapitalSummaryDomain capitalSummaryDomainService = ScaComponentFactory.getService(IBptCapitalSummaryDomain.class,"bptCapitalSummaryDomain/bptCapitalSummaryDomain");
	
	/**
	  * 获得上期生成日期和发放结束日期
	  * @param organId
	  */
	public void getPreBuildDate(){
		String organId = (String)getParameter("organCode");
		organId = organId.substring(0, 6);
		String registerType = (String)getParameter("registerType");
		String[] rusult  = capitalDetailDomainService.getPreBuildDate(organId,registerType);
		String preBuildDate = rusult[0];
		String preEndDate =  rusult[1];
		setReturn("preBuildDate", preBuildDate);
		setReturn("preEndDate", preEndDate);
	}
	
	/**
	 * 添加伤残资金发放汇总并通过调用存储过程添加伤残抚恤金发放名册
	 */
	@Trans
	public void insertDisaPension(){
		String uuid = IdHelp.getUUID32();
		ParameterSet pset = getParameterSet();
		pset.setParameter("uuid", uuid);
		capitalDetailDomainService.insertDisaPesionDetail(pset);
	}
	
	/**
	 * 添加三属资金发放汇总并通过调用存储过程添加三属定期抚恤金发放名册
	 */
	@Trans
	public void insertDepdtPension(){
		String uuid = IdHelp.getUUID32();
		ParameterSet pset = getParameterSet();
		pset.setParameter("uuid", uuid);
		capitalDetailDomainService.insertDepdtPesionDetail(pset);
	}
	
	/**
	 * 添加{复员军人}定期定量生活补助金发放汇总并通过{调用存储过程}添加发放名册
	 */
	@Trans
	public void insertDemobilizedPension(){
		String uuid = IdHelp.getUUID32();
		ParameterSet pset = getParameterSet();
		pset.setParameter("uuid", uuid);
		capitalDetailDomainService.insertDemobilizedPesionDetail(pset);
	}
	
	/**
	 * 添加{带病回乡退伍军人}生活补助金发放{汇总}，并通过{调用存储过程}添加发放名册
	 */
	@Trans
	public void insertDemobilizedIllPension(){
		String uuid = IdHelp.getUUID30();
		ParameterSet pset = getParameterSet();
		pset.setParameter("uuid", uuid);
		capitalDetailDomainService.insertDemobilizedPesionIllDetail(pset);
	}
	/**
	 * 添加{60岁}生活补助金发放{汇总}，并通过{调用存储过程}添加发放名册
	 */
	@Trans
	public void insertSoldierPension(){
		String uuid = IdHelp.getUUID30();
		ParameterSet pset = getParameterSet();
		pset.setParameter("uuid", uuid);
		capitalDetailDomainService.insertSoldierPesionIllDetail(pset);
	}
	/**
	 * 添加{老列子女}生活补助金发放{汇总}，并通过{调用存储过程}添加发放名册
	 */
	@Trans
	public void insertMartyrPension(){
		String uuid = IdHelp.getUUID30();
		ParameterSet pset = getParameterSet();
		pset.setParameter("uuid", uuid);
		capitalDetailDomainService.insertMartyrPesionIllDetail(pset);
	}
	/**
	 * 添加生活补助费发放汇总并通过调用存储过程添加生活补助费发放名册
	 */
	@Trans
	public void insertLivingAllowancePension(){
		String uuid = IdHelp.getUUID30();
		ParameterSet pset = getParameterSet();
		pset.setParameter("uuid", uuid);
		capitalDetailDomainService.insertLivingAllowPesionDetail(pset);
	}
	
	@Trans
	public void insert() {
		Record record = (Record) getParameter("record");
		BptCapitalDetail dataBean = (BptCapitalDetail) record
				.toBean(BptCapitalDetail.class);
		detailDao.insert(dataBean);
	}
	@Trans
	public void update() {
		Record record = (Record) getParameter("record");
		BptCapitalDetail dataBean = (BptCapitalDetail) record
				.toBean(BptCapitalDetail.class);
		detailDao.update(dataBean);
	}
	@Trans
	public void delete() {
		String[] delIds = (String[]) getParameter("delIds");
		detailDao.batchDelete(delIds);
	}
	
    /**
     * 保存名册明细表数据
     */
	@Trans
	public void saveData() {
		Record[] records = (Record[]) getParameter("records");
		String registerId = records[0].get("registerId").toString();
		ParameterSet pset = new ParameterSet();
		pset.setParameter("registerId", registerId);
		// 明细表
		List<BptCapitalDetail> list = new ArrayList<BptCapitalDetail>();
		for (int i = 0; i < records.length; i++) {
			BptCapitalDetail detailDataBean = (BptCapitalDetail) records[i].toBean(BptCapitalDetail.class);
			list.add(detailDataBean);
		}
		capitalDetailDomainService.saveBptCapialDetail(list);
		updateSummary(pset);
	}
	
	/**
	 * 修改优抚资金发放汇总
	 */
	@Trans
	private void updateSummary(ParameterSet pset){
		capitalSummaryDomainService.updateSummary(pset);
	}
	
	/**
	 * 新增伤残抚恤金发放对象
	 */
	@Trans
	public void addDisabiGrantObject(){
		ParameterSet pset = getParameterSet();
		DataSet newDisabiGrantDs = capitalDetailDomainService.getNewDisabiGrantDs(pset);
		Record rd = newDisabiGrantDs.getRecord(0);
		this.setReturn("rd", rd);
		
		String registerId =(String)rd.get("registerId");
		String peopleId =(String)rd.get("peopleId");
		pset.clear();
		pset.setParameter("REGISTER_ID", registerId);
		String changeState = (String)pset.getParameter("CHANGE_STATE");
		pset.setSortField("DOMICILE_CODE,DISABILITY_LEVEL_CODE,DISABILITY_CASE_CODE,DISABILITY_GENUS_CODE,OBJECT_TYPE,BELONG_DATE,DOMICILE_TYPE,NAME");
		if(changeState==null||changeState.equals("")){
        	pset.remove("CHANGE_STATE");
        }
		DataSet ds = detailDao.query(pset);
		for(int i=0 ;i<ds.getCount();i++){
			if(peopleId.equals((String)ds.getRecord(i).get("peopleId"))){
				this.setReturn("flag", "1");
				break;
			}
		}
		
	}
	
	/**
	 * 新增三属抚恤金发放对象
	 */
	@Trans
	public void addDepandGrantObject(){
		ParameterSet pset = getParameterSet();
		DataSet newDepandGrantDs = capitalDetailDomainService.getNewDepandGrantDs(pset);
		Record rd = newDepandGrantDs.getRecord(0);
		this.setReturn("rd", rd);
		
		String registerId =(String)rd.get("registerId");
		String peopleId =(String)rd.get("peopleId");
		pset.clear();
		pset.setParameter("REGISTER_ID", registerId);
		String changeState = (String)pset.getParameter("CHANGE_STATE");
		pset.setSortField("DOMICILE_CODE,DISABILITY_LEVEL_CODE,DISABILITY_CASE_CODE,DISABILITY_GENUS_CODE,OBJECT_TYPE,BELONG_DATE,DOMICILE_TYPE,NAME");
		if(changeState==null||changeState.equals("")){
        	pset.remove("CHANGE_STATE");
        }
		DataSet ds = detailDao.query(pset);
		for(int i=0 ;i<ds.getCount();i++){
			if(peopleId.equals((String)ds.getRecord(i).get("peopleId"))){
				this.setReturn("flag", "1");
				break;
			}
		}
	}
	
	/**
	 * 新增复员军人抚恤金发放对象
	 */
	@Trans
	public void addDemobilizedGrantObject(){
		ParameterSet pset = getParameterSet();
		DataSet newDepandGrantDs = capitalDetailDomainService.getNewDemobilizedGrantDs(pset);
		Record rd = newDepandGrantDs.getRecord(0);
		this.setReturn("rd", rd);
		
		String registerId =(String)rd.get("registerId");
		String peopleId =(String)rd.get("peopleId");
		pset.clear();
		pset.setParameter("REGISTER_ID", registerId);
		String changeState = (String)pset.getParameter("CHANGE_STATE");
		pset.setSortField("DOMICILE_CODE,DISABILITY_LEVEL_CODE,DISABILITY_CASE_CODE,DISABILITY_GENUS_CODE,OBJECT_TYPE,BELONG_DATE,DOMICILE_TYPE,NAME");
		if(changeState==null||changeState.equals("")){
        	pset.remove("CHANGE_STATE");
        }
		DataSet ds = detailDao.query(pset);
		for(int i=0 ;i<ds.getCount();i++){
			if(peopleId.equals((String)ds.getRecord(i).get("peopleId"))){
				this.setReturn("flag", "1");
				break;
			}
		}
	}
	
	/**
	 * 新增带病回乡退伍军人发放对象
	 */
	@Trans
	public void addDemobilizedIllGrantObject(){
		ParameterSet pset = getParameterSet();
		DataSet newDepandGrantDs = capitalDetailDomainService.getNewSoldierGrantDs(pset);
		Record rd = newDepandGrantDs.getRecord(0);
		this.setReturn("rd", rd);
		
		String registerId =(String)rd.get("registerId");
		String peopleId =(String)rd.get("peopleId");
		pset.clear();
		pset.setParameter("REGISTER_ID", registerId);
		String changeState = (String)pset.getParameter("CHANGE_STATE");
		pset.setSortField("DOMICILE_CODE,DISABILITY_LEVEL_CODE,DISABILITY_CASE_CODE,DISABILITY_GENUS_CODE,OBJECT_TYPE,BELONG_DATE,DOMICILE_TYPE,NAME");
		if(changeState==null||changeState.equals("")){
        	pset.remove("CHANGE_STATE");
        }
		DataSet ds = detailDao.query(pset);
		for(int i=0 ;i<ds.getCount();i++){
			if(peopleId.equals((String)ds.getRecord(i).get("peopleId"))){
				this.setReturn("flag", "1");
				break;
			}
		}
	}
	/**
	 * 新增60周岁发放对象
	 */
	@Trans
	public void addSoldierGrantObject(){
		ParameterSet pset = getParameterSet();
		DataSet newDepandGrantDs = capitalDetailDomainService.getNewDemobilizedIllGrantDs(pset);
		Record rd = newDepandGrantDs.getRecord(0);
		this.setReturn("rd", rd);
		
		String registerId =(String)rd.get("registerId");
		String peopleId =(String)rd.get("peopleId");
		pset.clear();
		pset.setParameter("REGISTER_ID", registerId);
		String changeState = (String)pset.getParameter("CHANGE_STATE");
		pset.setSortField("DOMICILE_CODE,DISABILITY_LEVEL_CODE,DISABILITY_CASE_CODE,DISABILITY_GENUS_CODE,OBJECT_TYPE,BELONG_DATE,DOMICILE_TYPE,NAME");
		if(changeState==null||changeState.equals("")){
        	pset.remove("CHANGE_STATE");
        }
		DataSet ds = detailDao.query(pset);
		for(int i=0 ;i<ds.getCount();i++){
			if(peopleId.equals((String)ds.getRecord(i).get("peopleId"))){
				this.setReturn("flag", "1");
				break;
			}
		}
	}
	/**
	 * 新增生活补助费发放对象
	 */
	@Trans
	public void addNewLiveAllowGrantObject(){
		ParameterSet pset = getParameterSet();
		DataSet newDepandGrantDs = capitalDetailDomainService.getNewLiveAllowGrantDs(pset);
		Record rd = newDepandGrantDs.getRecord(0);
		this.setReturn("rd", rd);
		
		String registerId =(String)rd.get("registerId");
		String peopleId =(String)rd.get("peopleId");
		pset.clear();
		pset.setParameter("REGISTER_ID", registerId);
		String changeState = (String)pset.getParameter("CHANGE_STATE");
		pset.setSortField("DOMICILE_CODE,DISABILITY_LEVEL_CODE,DISABILITY_CASE_CODE,DISABILITY_GENUS_CODE,OBJECT_TYPE,BELONG_DATE,DOMICILE_TYPE,NAME");
		if(changeState==null||changeState.equals("")){
        	pset.remove("CHANGE_STATE");
        }
		DataSet ds = detailDao.query(pset);
		for(int i=0 ;i<ds.getCount();i++){
			if(peopleId.equals((String)ds.getRecord(i).get("peopleId"))){
				this.setReturn("flag", "1");
				break;
			}
		}
	}
}
