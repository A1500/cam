package com.inspur.cams.bpt.capital.domain.support;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.bpt.capital.dao.IBptCapitalRetStaDao;
import com.inspur.cams.bpt.capital.data.BptCapitalRetMarSta;
import com.inspur.cams.bpt.capital.domain.IBptCapitalRetStaDomain;
import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
/**
 * @title 农村退役士兵补助标准domain
 * @author Lin Yangyang
 *
 */
public class BptCapitalRetStaDomain implements IBptCapitalRetStaDomain{
	@Reference
	private IBptCapitalRetStaDao bptCapitalRetStaDao ;
	/**
	 * 保存功能
	 */
	public void save(ParameterSet pset){
		Record record = (Record)pset.getParameter("record");
		String startDate = (String)record.get("startDate");
		String standardsCounties = (String)pset.getParameter("standardsCounties");
		String objectType = (String)pset.getParameter("objectType");
		List<BptCapitalRetMarSta> list = new ArrayList<BptCapitalRetMarSta>();
		BptCapitalRetMarSta dataBean = (BptCapitalRetMarSta) record.toBean(BptCapitalRetMarSta.class);
		//如果该区县存在，先修改之前startDate最大的结束日期，并将保存现有标准，否则，直接保存
		if(dataBean.isNew()==true){
			//查询标准是否存在
			ParameterSet queryset=  new ParameterSet();
			queryset.setParameter("standardsCounties",standardsCounties);
			queryset.setParameter("objectType",objectType);
			DataSet ds = this.getMaxDate(queryset);
			if(ds!=null){
				String maxDate = (String)ds.getRecord(0).get("START_DATE");//上一条记录的生效日期起
				//获取日期前一天
				String []str = startDate.split("[-]");
				int j = str.length;
				int[] num = new int[j];
				for(int i=0;i<str.length;i++){
					num[i] = Integer.parseInt(str[i]); 
				}
				SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd");
				Calendar cal=Calendar.getInstance();
				cal.set(Calendar.YEAR, num[0]);
				cal.set(Calendar.MONTH, num[1]-1);
				cal.set(Calendar.DAY_OF_MONTH, num[2]);
				cal.add(Calendar.DATE, -1);
				Date date=cal.getTime();
				String endDate = df.format(date);
				
		    	ParameterSet params = new ParameterSet();
		    	params.setParameter("endDate", endDate);
		    	params.setParameter("startDate",maxDate);
		    	bptCapitalRetStaDao.udpateEndDate(params);
			}
			//新增
			dataBean.setId(IdHelp.getUUID32());
			dataBean.setStandardsCounties(BspUtil.getOrganCode());
			dataBean.setObjectType("81");
			dataBean.setRegId(BspUtil.getEmpOrganId());
			dataBean.setRegTime(DateUtil.getDay());
		}else{//修改
			dataBean.setModId(BspUtil.getEmpOrganId());
			dataBean.setModTime(DateUtil.getDay());
		}
		list.add(dataBean);
		bptCapitalRetStaDao.save(list);
	}
	/**
	 * 批量删除功能
	 */
	public void deleteList(ParameterSet pset){
		Record[] records = (Record[])pset.getParameter("records");
		for(int i=0;i<records.length;i++){
			String id = (String)records[i].get("id");
			bptCapitalRetStaDao.delete(id);
		}
	}
	/**
	 * 查询功能
	 */
	public DataSet query(ParameterSet pset){
		return bptCapitalRetStaDao.query(pset);
	}
	/**
	 * 获得最大生效日期起
	 * @param pset
	 */
	public DataSet getMaxDate(ParameterSet pset){
		ParameterSet params = new ParameterSet();
		params.setParameter("objectType",(String) pset.getParameter("objectType"));
		params.setParameter("standardsCounties",(String) pset.getParameter("standardsCounties"));
		DataSet dss =bptCapitalRetStaDao.getMaxDate(params);
		return dss;
	}
}
