package com.inspur.cams.welfare.base.domain.support;

import java.text.DecimalFormat;
import java.text.NumberFormat;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.welfare.base.dao.support.WealComfortNoDao;
import com.inspur.cams.welfare.base.data.WealComfortNo;
import com.inspur.cams.welfare.base.domain.IWealComfortNoDomain;

public class WealComfortNoDomain implements IWealComfortNoDomain{
	private WealComfortNoDao wealComfortNoDao = (WealComfortNoDao) DaoFactory
			.getDao("com.inspur.cams.welfare.base.dao.support.WealComfortNoDao");
	private DateUtil dateUtil=new DateUtil();
public String getNO( String flag,String domicileCode){
		
		ParameterSet pst= new ParameterSet();
		pst.setParameter("domicile_code", domicileCode.substring(0, 6));
		if("Q".equals(flag)){
			pst.setParameter("CORPORATION_TYPE", "1");//假肢
		}else if("F".equals(flag)){
			pst.setParameter("CORPORATION_TYPE", "2");//福利
		}
		DataSet ds = wealComfortNoDao.query(pst);
		String no=null;
		if(ds.getCount()==1){
			WealComfortNo bean =(WealComfortNo)ds.getRecord(0).toBean(WealComfortNo.class);
			no =returnNo(domicileCode,bean.getQualificationNo());
			bean.setQualificationNo(no);
			wealComfortNoDao.update(bean);
		}else if(ds.getCount()<1){
			WealComfortNo bean =new WealComfortNo();
			bean.setDomicileCode(domicileCode.substring(0, 6));
			no =returnNo(domicileCode,bean.getQualificationNo());
			bean.setQualificationNo(no);
			if("Q".equals(flag)){
				bean.setCorporationType("1");
			}else if("F".equals(flag)){
				bean.setCorporationType("2");
			}
			wealComfortNoDao.insert(bean);
		}
		return no;
	}
	//370103-2013-001
	public String returnNo(String domicileCode,String no){
		StringBuffer NO = new StringBuffer();
		String date = (String)dateUtil.getYear();
		String domicile = domicileCode.substring(0, 6);
		NO.append(domicile);
		NO.append("-");
		if(no!=null){
			String NoDate= no.substring(7, 11);
			String NoNum = no.substring(12);
			Integer num = Integer.parseInt(NoNum)+1;
			NumberFormat formatter = new DecimalFormat("000");
			String number = formatter.format(num);   
			
			if(NoDate.equals(date)){
				NO.append(NoDate);
				NO.append("-");
				NO.append(number);
			}else{
				NO.append(date);
				NO.append("-");
				NO.append("001");
			}
			return NO.toString();
		}else{
			NO.append(date);
			NO.append("-");
			NO.append("001");
			return NO.toString();
		}
		
	}
		/*public static void main(String[] args) {   
			NumberFormat formatter = new DecimalFormat("0000000");   
			String number = formatter.format(2500);   
			System.out.println("Number with lading zeros: " + number);  
		}*/
}
