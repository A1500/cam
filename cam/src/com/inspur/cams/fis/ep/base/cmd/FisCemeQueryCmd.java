package com.inspur.cams.fis.ep.base.cmd;

import java.util.ArrayList;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.util.StrUtil;
import com.inspur.cams.fis.ep.base.dao.jdbc.FisCemeDao;
import com.inspur.cams.fis.ep.base.domain.IFisCemeDomain;


/**
 * @title:FisCemeQueryCommand
 * @description:公墓信息QueryCmd
 * @author:lidongdong
 * @since:2011-11-14
 * @version:1.0
*/
public class FisCemeQueryCmd extends BaseQueryCommand{
    IFisCemeDomain service = ScaComponentFactory.getService(IFisCemeDomain.class,
	"FisCemeDomain/FisCemeDomain");
    
    //获取当前单位下属公墓信息（带年检信息）
    public DataSet queryCemeBySql() {
    	ParameterSet pset = getParameterSet();
    	return service.queryCemeBySql(pset);
    }
    
	public DataSet execute() {
		ParameterSet pset = getParameterSet();

		DataSet samMBalanceDS = service.query(pset);
		ArrayList<Record> list = new ArrayList<Record>();
		for (int i = 0; i < samMBalanceDS.getCount(); i++) {
			// 将金额数字格式化到小数点后两位
			Record samMBalanceRecord = samMBalanceDS.getRecord(i);
			if(samMBalanceRecord.get("fixeDassets")!=null){
			samMBalanceRecord.set("fixeDassets", StrUtil
					.changeTwoDecimal(samMBalanceRecord.get("fixeDassets")
							.toString()));
			}
			if(samMBalanceRecord.get("totalInvestment")!=null){
				samMBalanceRecord.set("totalInvestment", StrUtil
						.changeTwoDecimal(samMBalanceRecord.get("totalInvestment")
								.toString()));
				}
			if(samMBalanceRecord.get("totalArea")!=null){
				samMBalanceRecord.set("totalArea", StrUtil
						.changeTwoDecimal(samMBalanceRecord.get("totalArea")
								.toString()));
				}
			if(samMBalanceRecord.get("builtArea")!=null){
				samMBalanceRecord.set("builtArea", StrUtil
						.changeTwoDecimal(samMBalanceRecord.get("builtArea")
								.toString()));
				}
			if(samMBalanceRecord.get("builtTotalArea")!=null){
				samMBalanceRecord.set("builtTotalArea", StrUtil
						.changeTwoDecimal(samMBalanceRecord.get("builtTotalArea")
								.toString()));
				}
			list.add(samMBalanceRecord);
		}
		DataSet ds = new DataSet();
		ds.getRecordSet().addAll(list);
		ds.setTotalCount(samMBalanceDS.getTotalCount());
		return ds;
	}
	
	public DataSet queryForPrintInfo(){
		ParameterSet pset = getParameterSet();
		FisCemeDao dao = (FisCemeDao) DaoFactory.getDao(FisCemeDao.class);
		return dao.queryForPrintInfo(pset);
		
	}

	
	/**
	 * 查询统计到的公墓的详细信息
	 * @return
	 */
	public DataSet  queryResult(){
		ParameterSet pset = getParameterSet();
		DataSet samMBalanceDS = service.queryResult(pset);
		ArrayList<Record> list = new ArrayList<Record>();
		for (int i = 0; i < samMBalanceDS.getCount(); i++) {
			// 将金额数字格式化到小数点后两位
			Record samMBalanceRecord = samMBalanceDS.getRecord(i);
			if(samMBalanceRecord.get("fixeDassets")!=null){
			samMBalanceRecord.set("fixeDassets", StrUtil
					.changeTwoDecimal(samMBalanceRecord.get("fixeDassets")
							.toString()));
			}
			if(samMBalanceRecord.get("totalInvestment")!=null){
				samMBalanceRecord.set("totalInvestment", StrUtil
						.changeTwoDecimal(samMBalanceRecord.get("totalInvestment")
								.toString()));
				}
			if(samMBalanceRecord.get("totalArea")!=null){
				samMBalanceRecord.set("totalArea", StrUtil
						.changeTwoDecimal(samMBalanceRecord.get("totalArea")
								.toString()));
				}
			if(samMBalanceRecord.get("builtArea")!=null){
				samMBalanceRecord.set("builtArea", StrUtil
						.changeTwoDecimal(samMBalanceRecord.get("builtArea")
								.toString()));
				}
			if(samMBalanceRecord.get("builtTotalArea")!=null){
				samMBalanceRecord.set("builtTotalArea", StrUtil
						.changeTwoDecimal(samMBalanceRecord.get("builtTotalArea")
								.toString()));
				}
			list.add(samMBalanceRecord);
		}
		DataSet ds = new DataSet();
		ds.getRecordSet().addAll(list);
		ds.setTotalCount(samMBalanceDS.getTotalCount());
		return ds;
	}
	/**
	 * 查询公墓系统上报信息（公墓部署）
	 * @return
	 */
	public DataSet queryImportCemeInfo(){
    	ParameterSet pset = getParameterSet();
    	return service.queryImportCemeInfo(pset);
	}

	/**
	 * @Description: 公墓树查询
	 * @author xuexzh
	 */
	public DataSet queryOrganByUnitId() {
		ParameterSet pset = getParameterSet();
		DataSet ds = service.queryOrganByUnitId(pset);
		ds.getMetaData().setIdProperty("ORGAN_CODE");
		return ds;
	}
}
