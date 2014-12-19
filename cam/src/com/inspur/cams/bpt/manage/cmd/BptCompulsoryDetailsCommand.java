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

import com.inspur.cams.bpt.capital.dao.jdbc.BptCapitalstaDao;
import com.inspur.cams.bpt.capital.data.BptCompulsoryDetails;
import com.inspur.cams.bpt.capital.data.BptCompulsorySummary;
import com.inspur.cams.bpt.capital.domain.IBptCompulsoryDetailsDomain;
import com.inspur.cams.bpt.capital.domain.IBptCompulsorySummaryDomain;
import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;

/**
 * @title:优待金 
 */
public class BptCompulsoryDetailsCommand extends BaseAjaxCommand{
	//获得优待金发放服务接口
	private IBptCompulsoryDetailsDomain compulDetailService = ScaComponentFactory.getService(IBptCompulsoryDetailsDomain.class,
	"bptCompulsoryDetailsDomain/bptCompulsoryDetailsDomain");
	
	//获得优待金汇总接口
	private IBptCompulsorySummaryDomain compulSummaryService = ScaComponentFactory.getService(IBptCompulsorySummaryDomain.class,
	"bptCompulsorySummaryDomain/bptCompulsorySummaryDomain");
	
	private BptCapitalstaDao compulStaDao = (BptCapitalstaDao) DaoFactory.getDao("com.inspur.cams.bpt.capital.dao.jdbc.BptCapitalstaDao");
	
	/**
	 * 当改变义务兵优待金发放所属年度，查询优待金和进藏进疆增发金额
	 */
	public void queryBelongDateChange(){
		String belongDate = getParameter("belongDate").toString();
		String composedPortrait = getParameter("composedPortrait").toString();
		String domicileType = getParameter("domicileType").toString();
		String organCode = getParameter("organCode").toString();
		ParameterSet pset = new ParameterSet();
		pset.setParameter("SUBSTR(START_DATE,1,4)", belongDate);
		pset.setParameter("STANDARDS_COUNTIES", organCode);
		pset.setParameter("IN_TIBET", composedPortrait);
		pset.setParameter("DOMICILE_TYPE", domicileType);
		Record compulsorySta = compulStaDao.query(pset).getRecord(0);
		if(compulsorySta.get("inTibetAdditional")!=null&&!compulsorySta.get("inTibetAdditional").equals("")){
			String inTibetAdditional = compulsorySta.get("inTibetAdditional").toString();
			setReturn("inTibetAdditional",inTibetAdditional);
		}
		if(compulsorySta.get("newmoonStandards")!=null&&!compulsorySta.get("newmoonStandards").equals("")){
			String newmoonStandards = compulsorySta.get("newmoonStandards").toString();
			setReturn("newmoonStandards",newmoonStandards);
		}
	}
	
	/**
	 * 添加义务兵优待金发放明细
	 */
	@Trans
	public void compulsoryDetailAdd(){
		Record record = (Record) getParameter("record");
		BptCompulsoryDetails dataBean=(BptCompulsoryDetails)record.toBean(BptCompulsoryDetails.class);
		dataBean.setGrantNumber(String.valueOf((Integer.parseInt(record.get("grantNumber").toString())+1)));//保存一次，发放次数加1
		compulDetailService.addCompulDetail(dataBean);
	}
	
	/**
	 * 除义务兵家庭外其他优抚对象优待金发放添加生成明细(调用存储过程)
	 */
	public void queryNonCompulsoryGenerateData(){
 		ParameterSet pset = getParameterSet();
 		String mcid = IdHelp.getUUID32();
 		pset.setParameter("mcid",mcid);
 		compulDetailService.queryNonCompulsoryGenerateData(pset);
 		setReturn("mcid",mcid);
	}
	
	 /**
	  * 修改非义务兵优待金数据
	  */
	@Trans
	public void updateNonCompul() {
		Record[] records = (Record[]) getParameter("records");
		String registerId = records[0].get("registerId").toString();
		ParameterSet pset = new ParameterSet();
		pset.setParameter("registerId",registerId);
		List<BptCompulsoryDetails> list = new ArrayList<BptCompulsoryDetails>();
		for(int i=0;i<records.length;i++){
			BptCompulsoryDetails compulsoryDetails = (BptCompulsoryDetails)records[i].toBean(BptCompulsoryDetails.class);
			list.add(compulsoryDetails);
		}
		compulDetailService.batchUpdateNonCompulsory(list);
		updateNonCompuSumm(pset);
	}
	
	/**
	 * 修改优待金总额
	 */
	@Trans
	private void updateNonCompuSumm(ParameterSet pset){
		compulSummaryService.updateNonCompuSumm(pset);
	}
	@Trans
	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		compulDetailService.deleteCompulsoryDetail(delIds);
	}
	
	/**
	 * 修改义务兵优待金发放
	 */
	@Trans
	public void updateCompulsory(){
		Record record = (Record)getParameter("record");
		BptCompulsoryDetails compulsoryDetails = (BptCompulsoryDetails)record.toBean(BptCompulsoryDetails.class); 
		compulDetailService.updateCompulDetail(compulsoryDetails);
	}
	
	/**
	 * 新增优待金（非义务兵）发放对象
	 */
	@Trans
	public void addNewCompulsoryGrantObject(){
		ParameterSet pset = getParameterSet();
		DataSet ds = compulDetailService.getNewCompulsoryGrantObject(pset);
		Record rd = ds.getRecord(0);
		setReturn("rd", rd);
		
		String registerId =(String)rd.get("registerId");
		String peopleId =(String)rd.get("peopleId");
		pset.clear();
		pset.setParameter("registerId", registerId);
		pset.setParameter("sort", "DOMICILE_CODE,NAME");
		DataSet dsu = compulDetailService.queryCompulsoryUpdate(pset);
		for(int i=0 ;i<dsu.getCount();i++){
			if(peopleId.equals((String)dsu.getRecord(i).get("peopleId"))){
				this.setReturn("flag", "1");
				break;
			}
		}
	}
}
