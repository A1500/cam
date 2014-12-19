package com.inspur.cams.drel.sam.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.drel.sam.dao.ISamCardNoDao;
import com.inspur.cams.drel.sam.data.SamCardNo;
import com.inspur.cams.drel.sam.domain.ISamCardNoDomain;

/**
 * @title:低保证号domain
 * @description:
 * @author:zhangjian
 * @since:2011-06-14
 * @version:1.0
 */
public class SamCardNoDomain implements ISamCardNoDomain {
	@Reference
	private ISamCardNoDao samCardNoDao;

	public synchronized String getCardNo(String cardType, String domicileCode) {
		ParameterSet pst = new ParameterSet();
		pst.setParameter("domicile_code", domicileCode.substring(0, 9));
		DataSet ds = samCardNoDao.query(pst);
		String cardNo = null;
		if (ds.getCount() == 1) {
			SamCardNo samCardNo = (SamCardNo) ds.getRecord(0).toBean(SamCardNo.class);
			if ("C".equals(cardType)) {
				cardNo = returnCardNo(cardType, domicileCode, samCardNo.getCityNo());
				samCardNo.setCityNo(cardNo);
			} else if ("N".equals(cardType)) {
				cardNo = returnCardNo(cardType, domicileCode, samCardNo.getCountryNo());
				samCardNo.setCountryNo(cardNo);
			} else if ("W".equals(cardType)) {
				cardNo = returnCardNo(cardType, domicileCode, samCardNo.getFiveNo());
				samCardNo.setFiveNo(cardNo);
			}
			samCardNoDao.update(samCardNo);
		} else if (ds.getCount() < 1) {
			SamCardNo samCardNo = new SamCardNo();
			samCardNo.setDomicileCode(domicileCode.substring(0, 9));
			if ("C".equals(cardType)) {
				cardNo = returnCardNo(cardType, domicileCode, samCardNo.getCityNo());
				samCardNo.setCityNo(cardNo);
			} else if ("N".equals(cardType)) {
				cardNo = returnCardNo(cardType, domicileCode, samCardNo.getCountryNo());
				samCardNo.setCountryNo(cardNo);
			} else if ("W".equals(cardType)) {
				cardNo = returnCardNo(cardType, domicileCode, samCardNo.getFiveNo());
				samCardNo.setFiveNo(cardNo);
			}
			samCardNoDao.insert(samCardNo);
		}
		return cardNo;
	}

	public String returnCardNo(String cardType, String domicileCode, String lastCardNo) {
		StringBuffer cardNo = new StringBuffer();
		String year = (String) DateUtil.getYear();
		String domicile = domicileCode.substring(0,9);
		cardNo.append(cardType);
		cardNo.append(domicile);
		if (lastCardNo != null) {
			String noYear = lastCardNo.substring(10, 14);
			String lastNo = lastCardNo.substring(10);
			if(lastNo.length() == 7 ){
				lastNo = lastNo.substring(0,4)+"00"+lastNo.substring(4,7);//转成5位
			}
			Integer num = Integer.parseInt(lastNo) + 1;
			String no = num.toString().substring(4);

			if (noYear.equals(year)) {
				cardNo.append(noYear);
				cardNo.append(no);
			} else {
				cardNo.append(year);
				cardNo.append("00001");
			}
			return cardNo.toString();
		} else {
			cardNo.append(year);
			cardNo.append("00001");
			return cardNo.toString();
		}
	}
}
