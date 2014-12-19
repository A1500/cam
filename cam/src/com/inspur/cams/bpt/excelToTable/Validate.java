package com.inspur.cams.bpt.excelToTable;

import java.sql.Types;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.Record;
import org.loushang.persistent.util.domain.BaseJdbcDao;

import com.inspur.cams.bpt.excelToTable.dao.MessageDao;
import com.inspur.cams.comm.util.BspUtil;


/**
 * 读取校验 *
 * 
 * @author 
 * 
 */
public class Validate {
	protected static final Log logger = LogFactory.getLog(BaseJdbcDao.class);
	private String field;
	String[] a = { "0", "" };
	
	public Validate(String field) {
		super();
		this.field = field;
	}

	
	/**
	 * 验证是否为为空
	 * @param fieldName 字段名称
	 * @return "0,验证通过" 或"1" 验证失败返回信息
	 */
	public  String[] require(String fieldName) {
		if(field==null||"".equals(field)){
			a[0]="1";
			a[1]=fieldName+"不能为空! ";
			return a;
		}else{
			return a;
		}
	}
	/**
	 * 验证身份证号是否正确
	 * @param fieldName 字段名称
	 * @return "0,验证通过" 或"1" 验证失败返回信息
	 */
	public  String[] checkIdCard() {
		if(field!=null&&!"".equals(field)){
			boolean msg =CheckIdCard.isIdCard(field);
			if(msg){
				return a;
			}else{
				a[0]="1";
				a[1]="身份证号错误! ";
				return a;
			}
		}else{
			return a;
		}
	}
	/**
	 * 验证是否是数字
	 * @param fieldName 字段名称
	 * @return "0,验证通过" 或"1" 验证失败返回信息
	 */
	public  String[] checkIsNum(String fieldName) {
		if(field!=null&&!"".equals(field)){
			Pattern pattern = Pattern.compile("[0-9]*[.]?[0-9]*");
			boolean b =pattern.matcher(field).matches();

			if(b){
				return a;
			}else{
				a[0]="1";
				a[1]=fieldName+"不是数字! ";
				return a;
			}
		}else{
			return a;
		}
	}
	/**
	 * 验证时间是否正确
	 * @param fieldName 字段名称
	 * @return "0,验证通过" 或"1" 验证失败返回信息
	 * 如 "2007-02-29"种格式为正确
	 */
	public  String[] checkDate(String fieldName) {
		if(field!=null&&!"".equals(field)){
			 String checkValue = "2007-02-29";        
             //String eL = "^((((1[6-9]|[2-9]\\d)\\d{2})-(0?[13578]|1[02])-(0?[1-9]|[12]\\d|3[01]))|(((1[6-9]|[2-9]\\d)\\d{2})-(0?[13456789]|1[012])-(0?[1-9]|[12]\\d|30))|(((1[6-9]|[2-9]\\d)\\d{2})-0?2-(0?[1-9]|1\\d|2[0-8]))|(((1[6-9]|[2-9]\\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))-0?2-29-)) (20|21|22|23|[0-1]?\\d):[0-5]?\\d:[0-5]?\\d$";        
                     
			 String eL= "^((\\d{2}(([02468][048])|([13579][26]))[\\-\\/\\s]?((((0?[13578])|(1[02]))[\\-\\/\\s]?((0?[1-9])|([1-2][0-9])|(3[01])))|(((0?[469])|(11))[\\-\\/\\s]?((0?[1-9])|([1-2][0-9])|(30)))|(0?2[\\-\\/\\s]?((0?[1-9])|([1-2][0-9])))))|(\\d{2}(([02468][1235679])|([13579][01345789]))[\\-\\/\\s]?((((0?[13578])|(1[02]))[\\-\\/\\s]?((0?[1-9])|([1-2][0-9])|(3[01])))|(((0?[469])|(11))[\\-\\/\\s]?((0?[1-9])|([1-2][0-9])|(30)))|(0?2[\\-\\/\\s]?((0?[1-9])|(1[0-9])|(2[0-8]))))))";        
             Pattern p = Pattern.compile(eL);         
             Matcher m = p.matcher(field);         
             boolean b = m.matches();        
             if(b){   
 				return a;
             } else{        
            	a[0]="1";
  				a[1]=fieldName+"日期格式错误! ";
  				return a;     
             }        
  
		}else{
			return a;
		}
	}
	/**
	 * 验证字段长度
	 * @param fieldName 字段名称
	 * @return "0,验证通过" 或"1" 验证失败返回信息
	 */
	public  String[] length(String min,String max,String fieldName) {
		if(field!=null&&!"".equals(field)){
			int mi=Integer.parseInt(min);
			int ma=Integer.parseInt(max);
			if(mi>=ma){
				a[0]="1";
				a[1]=fieldName+"验证参数错误! ";
			}else {
				if(field.length()>ma||field.length()<mi){
					a[0]="1";
					a[1]=fieldName+"长度应在"+mi+"与"+max+"之间! ";
				}
			}
			return a;
		}else{
			return a;
		}
	}
	/**
	 * 校验行政区划代码
	 * @param fieldName
	 * @return
	 */
	public String[] checkDomicile(String fieldName) {
		String organcode = BspUtil.getOrganCode();
		if(field!=null||!"".equals(field)){
			if(field.length()!=12){
				a[0]="1";
 				a[1]=fieldName+"长度错误!";
 				return a;
			}
			if(field.substring(0, 6).equals(organcode.substring(0, 6))){
				MessageDao dao = new MessageDao();
				DataSet ds = dao.queryDomicile(field);
				if(ds.getCount()<1){
					a[0]="1";
	 				a[1]="没有找到对应"+fieldName+"!";
	 				return a; 
				}
			}else{
				a[0]="1";
 				a[1]="请输入本市县的"+fieldName+"!";
 				return a; 
			}
			return a;
		}else{
			a[0]="1";
			a[1]="";
			return a; 
		}
	}
	/**
	 * 验证字段是否为正整数
	 * @param fieldName
	 * @return "0,验证通过" 或"1" 验证失败返回信息
	 */
	public String[] checkInt(String fieldName){
		if(field!=null||!"".equals(field)){
			     
			String eL= "^[0-9]*[1-9][0-9]*$";        
            Pattern p = Pattern.compile(eL);         
            Matcher m = p.matcher(field);         
            boolean b = m.matches();        
            if(b){   
				return a;
            } else{        
            	a[0]="1";
 				a[1]=fieldName+"必须为正整数!";
 				return a;     
            }        
 
		}else{
			return a;
		}
	}
	
	
	/**
	 * 验证字段是否为2011-10格式（年-月）
	 * @param fieldName
	 * @return "0,验证通过" 或"1" 验证失败返回信息
	 */
	public String[] checkMonth(String fieldName)  {
		if(field!=null||!"".equals(field)){
			String eL= "\\d{4}-((0?[0-9])|(1[0-2]))";        
            Pattern p = Pattern.compile(eL);         
            Matcher m = p.matcher(field);         
            boolean b = m.matches();        
            if(b){   
				return a;
            } else{        
            	a[0]="1";
 				a[1]=fieldName+"格式错误!";
 				return a;     
            }        
		} else {
			return a;
		}
	}
	
	
	public String[] checkMoney(String fieldName) {
		if(field!=null||!"".equals(field)){
			String eL= "^(([1-9]\\d*)|0)(\\.\\d{2})?$";        
            Pattern p = Pattern.compile(eL);         
            Matcher m = p.matcher(field);         
            boolean b = m.matches();        
            if(b){   
            	if(field.length() > 16) {
            		a[0]="1";
     				a[1]=fieldName+"长度过长!";
     				return a;  
            	}
				return a;
            } else{        
            	a[0]="1";
 				a[1]=fieldName+"格式错误!";
 				return a;     
            }        
		} else {
			return a;
		}
	}
	/**
	 * 根据id_card ,organ_code查找是否为重复数据
	 * @param r
	 * @param organ_code
	 * @return 1:数据重复
	 */
	public String[] isSameIdCard(String flag) {
		if(field!=null&&!"".equals(field)){
			MessageDao dao = new MessageDao();
			DataSet ds = dao.querySameIdcard(field);
			if(ds.getCount()>0){
				String f= (String)ds.getRecord(0).get(flag.toUpperCase());
				if(!"1".equals(f)){
					a[0]="duo";
					a[1]="多重身份！";
					return a;
				}else{
					a[0]="1";
					a[1]="该人员已在系统中！";
					return a;
				}
			}else
				return a;
		}else{
			a[0]="1";
			a[1]="";
			return a;
		}
	}
	/**
	 * 校验长度
	 * 
	 */
	public String[] lengthOf(String len,String fieldName ) {
		if(field!=null&&!"".equals(field)){
			byte[] buff=field.getBytes();
			int f=buff.length;
			int l= Integer.parseInt(len);
			if(f>l){
				
				a[0]="1";
				a[1]=fieldName+"长度过长!";
				return a; 
			}else
				return a;
		}else
			return a;
		
	}
	public String[] checkApanageCode(String fieldName)
	  {
	    String organcode = BspUtil.getOrganCode();
	    if ((this.field != null) || (!"".equals(this.field))) {
	      MessageDao dao = new MessageDao();
	      DataSet ds = dao.queryDomicile(this.field);
	      if (ds.getCount() < 1) {
	        this.a[0] = "1";
	        this.a[1] = ("没有找到对应" + fieldName + "!");
	        return this.a;
	      }
	      return this.a;
	    }

	    this.a[0] = "1";
	    this.a[1] = "";
	    return this.a;
	  }
}