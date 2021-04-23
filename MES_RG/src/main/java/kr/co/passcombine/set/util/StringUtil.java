package kr.co.passcombine.set.util;

import java.io.*;
import java.lang.reflect.Method;
import java.net.URLEncoder;
import java.text.*;
import java.util.*;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class StringUtil {

	private static final Logger logger = LoggerFactory.getLogger(StringUtil.class);

	/** ''을 나타내는 문자열 상수 **/
	public static final String EMPTY_STRING = "";

	static BitSet dontNeedEncoding;
	static final int caseDiff = 32;

	static {
		dontNeedEncoding = new BitSet(256);
		for (int i = 97; i <= 122; i++)
			dontNeedEncoding.set(i);

		for (int j = 65; j <= 90; j++)
			dontNeedEncoding.set(j);

		for (int k = 48; k <= 57; k++)
			dontNeedEncoding.set(k);

		dontNeedEncoding.set(32);
		dontNeedEncoding.set(45);
		dontNeedEncoding.set(95);
		dontNeedEncoding.set(46);
		dontNeedEncoding.set(42);
	}

	/**
	 * String의 null을 빈 값으로 변환한다.
	 * 
	 * @param String
	 * @return String
	 */
	public static String nullCheck(String s) {
		return s != null ? s : "";
	}

	/**
	 * String의 null 또는 빈값을 0 값으로 변환한다.
	 * 
	 * @param String
	 * @return int
	 */
	public static int numericCheck(String s) {
		return (s != null && !s.equals("")) ? Integer.parseInt(s) : 0;
	}

	/**
	 * String의 null을 빈 값으로 변환한다.
	 * 
	 * @param String
	 * @return String
	 */
	public static String nullCheck(String s, String val) {
		return s != null && !s.equals("null") ? s : val;
	}

	/**
	 * int가 0이 아닌경우에만 출력한다.
	 * 
	 * @param String
	 * @return String
	 */
	public static String zeroCheck(int s) {
		return s != 0 ? Integer.toString(s) : "&nbsp;";
	}

	/**
	 * String 중에 space가 있는지 체크한다.
	 * 
	 * @param String
	 * @return boolean
	 */
	public static boolean spaceCheck(String s) {

		boolean chk = true;
		String _s = nullCheck(s);

		try {
			if (_s.length() > 0) { // 길이가 0보다 큰 경우..

				for (int i = 0; i < _s.length(); i++) {
					if (Character.isWhitespace(_s.charAt(i))) { // java의 white space를
																											// 체크한다.
						chk = false;
						break;
					}
				}

			} else { // 길이가 0인 경우..
				chk = false;
			}
		} catch (Exception e) {
			logger.error(e.toString());
		}

		return chk;
	}

	/**
	 * 숫자인지 체크를 한다.
	 * 
	 * @param String
	 * @return boolean
	 */
	public static boolean numberCheck(String s) {
		boolean chk = true;
		String _s = nullCheck(s);
		try {
			for (int i = 0; i < _s.length(); i++) {
				if (!Character.isDigit(_s.charAt(i))) {
					chk = false;
					break;
				}
			}
		} catch (Exception e) {
			chk = false;
			logger.error(e.toString());
		}
		return chk;
	}

	/**
	 * 영문 대문자로 변환한다.
	 * 
	 * @param String
	 * @return String
	 */
	public static String getUpperCase(String s) {
		return nullCheck(s).toUpperCase();
	}

	/**
	 * StringTokenizer에서 특정번째에 문자열을 가져온다.
	 * 
	 * @param index
	 *          찾아올 문자 순서 int
	 * @param s
	 *          스트링 문자열 String
	 * @param token
	 *          구분자 String
	 * @return 변환된 String
	 */
	public static String getToken(int index, String s, String token) {
		StringTokenizer st = new StringTokenizer(s, token);
		StringBuffer sb = new StringBuffer("");
		for (int i = 0; st.hasMoreTokens(); i++) {
			if (index == i) {
				sb.append(st.nextToken());
				break;
			}
			st.nextToken();
		}

		if (sb.toString().length() > 0)
			return sb.toString().trim();
		else
			return "";
	}

	public static String toKor(String str) {
		return stringConvert("8859_1", "KSC5601", str);
	}

	/**
	 * @param obj
	 *          String type의 데이터
	 * 
	 * @return 8859_1로 encoding된 String
	 */
	public static String toEng(String str) {
		return stringConvert("KSC5601", "8859_1", str);
	}

	/**
	 * 문자 encoding을 합니다.
	 * 
	 * @param srcEncoding
	 *          String
	 * @param trgtEncoding
	 *          String
	 * @param str
	 *          String
	 * @return 변환된 String
	 */
	public static String stringConvert(String srcEncoding, String trgtEncoding, String str) {
		String value = null;
		try {
			value = new String(str.getBytes(srcEncoding), trgtEncoding);
		} catch (UnsupportedEncodingException e) {
			value = str;
		}
		return value;
	}

	/**
	 * src에서 str1와 str2를 replace하는 메소드
	 * 
	 * @param src
	 *          source String
	 * @param str1
	 *          pattern String
	 * @param str2
	 *          대치되어 들어갈 String
	 * @return 변환된 String
	 */
	public static String replace(String _target, String replaced, String replacer) {
		if (_target == null || replaced == null || replacer == null)
			return _target;

		StringBuffer target = new StringBuffer();

		int startIndex = 0;
		int endIndex = 0;
		int size = replaced.length();

		while ((endIndex = _target.indexOf(replaced, startIndex)) > -1) {
			target.append(_target.substring(startIndex, endIndex));
			target.append(replacer);
			startIndex = endIndex + size;
		}

		target.append(_target.substring(startIndex, _target.length()));

		return target.toString();
	}

	public static String replace(Object _target, String replaced, String replacer) {
		return replace(_target.toString(), replaced, replacer);
	}

	/**
	 * src에서 str1와 str2를 replace하는 메소드
	 * 
	 * @param src
	 *          source String
	 * @param str1
	 *          pattern String
	 * @param str2
	 *          대치되어 들어갈 String
	 * @return 변환된 String
	 */
	public static String replace2(String _target, String replaced, String replacer) {
		if (_target == null || replaced == null || replacer == null)
			return "";

		return replace(_target, replaced, replacer);
	}

	public static String replace2(Object _target, String replaced, String replacer) {
		return replace2(_target.toString(), replaced, replacer);
	}

	/**
	 * fIdx부터 tIdx까지 문자열을 자른다.<br/>
	 * 
	 * @param src
	 *          String
	 * @param fIdx
	 *          int
	 * @param tIdx
	 *          int
	 * @return String
	 */
	public static String substring(String src, int fIdx, int tIdx) {
		if (src == null)
			return "";

		// src = src.trim();

		if (fIdx < 0) {
			fIdx = 0;
		} else if (fIdx > src.length()) {
			fIdx = src.length();
		}

		if (tIdx < 0) {
			tIdx = 0;
		} else if (tIdx > src.length()) {
			tIdx = src.length();
		}

		if (fIdx == tIdx) {
			return src.substring(tIdx);
		} else if (fIdx > tIdx) {
			return "";
		} else {
			return src.substring(fIdx, tIdx);
		}
	}

	/**
	 * fIdx까지 문자열을 자른다.<br/>
	 * 
	 * @param src
	 *          String
	 * @param fIdx
	 *          int
	 * @return String
	 */
	public static String substring(String src, int fIdx) {
		if (src == null)
			return "";
		// src = src.trim();
		if (fIdx < 0)
			fIdx = 0;
		else if (fIdx > src.length())
			fIdx = src.length();

		return src.substring(fIdx);
	}

	public static String format(int value) {
		return format(value, "###,###,###");
	}

	public static String format(int value, String pattern) {
		DecimalFormat myFormatter = new DecimalFormat(pattern);
		return myFormatter.format(value);
	}

	public static String format(long value) {
		return format(value, "###,###,###");
	}

	public static String format(long value, String pattern) {
		DecimalFormat myFormatter = new DecimalFormat(pattern);
		return myFormatter.format(value);
	}

	public static String format(double value) {
		return format(value, "###,###,###");
	}

	public static String format(double value, String pattern) {
		DecimalFormat myFormatter = new DecimalFormat(pattern);
		return myFormatter.format(value);
	}

	public static String reserveformat(String value, int size) {
		return format(value, size, true);
	}

	public static String format(String value, int size, boolean isReserve) {
		if (value.length() > size) {
			if (isReserve)
				return value;
			else
				return value.substring(0, size);
		} else {
			StringBuffer sb = new StringBuffer(value);

			for (int i = 0; i < size - value.length(); i++) {
				sb.append(" ");
			}

			return sb.toString();
		}
	}

	/**
	 * 문자열에 Strike 태그 사용시(문자열에 가로줄)<br>
	 * 
	 * @param src
	 *          String
	 * @param intFlag
	 *          int(1이면 빈 공백에 가로줄, 2면 문자열에 가로줄)
	 * @return String
	 */
	public static String strikeFormat(String src, int intFlag) {
		if (src == null)
			return EMPTY_STRING;

		src = src.trim();

		if (intFlag == 1) {
			if (src.equals("0"))
				src = "<s>&nbsp;&nbsp;&nbsp;&nbsp;</s>";
		} else if (intFlag == 2) {
			src = "<s>" + src + "</s>";
		}

		return src;
	}

	/**
	 * 숫자형 문자열에 콤마 유무에 상관없이 천단위로 콤마를 찍어준다.<br>
	 * 숫자를 999,999,999 또는 999,999,999.99 형식으로 변환하는 메소드
	 * 
	 * @param src
	 *          String type의 숫자 데이터
	 * 
	 * @return 세자리마다 콤마를 찍어주는 변환된 String
	 */
	public static String commaFormat(String src) {
		if (src == null)
			return EMPTY_STRING;

		Double num;

		try {
			num = new Double(src);
		} catch (NumberFormatException nfe) {
			return "invalid argument";
		} catch (NullPointerException npe) {
			return "err-commaFormat(null)";
		}

		DecimalFormat df = new DecimalFormat("###,###,###.##");

		return df.format(num);
	}

	/**
	 * 999,999,999 또는 999,999,999.99 format으로 되어있는 자료를<br>
	 * ','가 없는 형식으로 변환하는 메소드
	 * 
	 * @param src
	 *          String type의 숫자 데이터
	 * @return 숫자 format으로 변환된 String
	 */
	public static String numberFormat(String src) {
		if (src == null)
			return "err-numberFormat(null)";
		StringBuffer res = new StringBuffer();

		StringTokenizer st = new StringTokenizer(src, ",");

		try {
			while (st.hasMoreTokens())
				res.append(st.nextToken());
		} catch (NoSuchElementException nse) {
		}

		return res.toString();
	}

	/**
	 * string에 "'" 가 들어가 있을 경우 "''"로 변환하는 메소드
	 * 
	 * @param src
	 *          String type의 데이터
	 * @return 변환된 String
	 */
	public static String encodeQuot(String src) {
		return replace(src, "'", "''");
	}

	/**
	 * string에 "'" 가 들어가 있을 경우 "''"로 변환하고,<br>
	 * string 양쪽에 %를 붙혀주고 양쪽을 "'"로 막아준다.<br>
	 * Sql 쿼리중 like형태에 맞게 반환하는 메소드<br>
	 * 
	 * @param src
	 *          String type의 데이터
	 * @return 변환된 String
	 */
	public static String rtnLikeSqlType(String src) {
		src = replace(src, "'", "''");
		src = "%" + src + "%";
		src = "'" + src + "'";
		return src;
	}

	/**
	 * string에 "'" 가 들어가 있을 경우 "''"로 변환하고,<br>
	 * string 맨 오른쪽에 %를 붙혀주고 양쪽을 "'"로 막아준다.<br>
	 * Sql 쿼리중 like형태에 맞게 반환하는 메소드<br>
	 * 
	 * @param src
	 *          String type의 데이터
	 * @return 변환된 String
	 */
	public static String rtnRLikeSqlType(String src) {
		src = replace(src, "'", "''");
		src = src + "%";
		src = "'" + src + "'";
		return src;
	}

	/**
	 * string에 "'" 가 들어가 있을 경우 "''"로 변환하고,<br>
	 * string 맨 앞에 %를 붙혀주고 양쪽을 "'"로 막아준다. <br>
	 * Sql 쿼리중 like형태에 맞게 반환하는 메소드<br>
	 * 
	 * @param src
	 *          String type의 데이터
	 * @return 변환된 String
	 */
	public static String rtnLLikeSqlType(String src) {
		src = replace(src, "'", "''");
		src = "%" + src;
		src = "'" + src + "'";
		return src;
	}

	/**
	 * string에 "'" 가 들어가 있을 경우 "\'"로 변환하는 메소드
	 * 
	 * @param src
	 *          String type의 데이터
	 * @return 변환된 String
	 */
	public static String escapeQuot(String src) {
		return replace(src, "'", "\'");
	}

	/**
	 * string의 양 끝에 '"'를 붙이는 메소드
	 * 
	 * @param src
	 *          String type의 데이터
	 * @return 변환된 String
	 */
	public static String addQuot(String src) {
		if (src == null)
			return EMPTY_STRING;

		return new String("'" + src + "'");
	}

	/**
	 * string src을 "'"를 "''"로 Convert한다.<br>
	 * string src의 양끝에 "'"를 붙이는 메소드
	 * 
	 * @param src
	 *          String type의 데이터
	 * @return String 변환된 데이터
	 */
	public static String sqlCharType(String src, int i) {
		src = nvl(src, "");
		src = encodeQuot(src);
		src = src.trim();

		if (i == 0)
			return new String(src);
		else
			return new String("'" + src + "'");
	}

	/**
	 * string src을 "'"를 "''"로 Convert한다.<br>
	 * string src의 양끝에 "'"를 붙이는 메소드
	 * 
	 * @param src
	 *          String type의 데이터
	 * @return String 변환된 데이터
	 */
	public static String sqlCharType(String src) {
		src = nvl(src, "");
		src = encodeQuot(src);
		src = src.trim();

		return new String("'" + src + "'");
	}

	/**
	 * String src의 좌측 space를 삭제하는 메소드
	 * 
	 * @param src
	 *          String type의 데이터
	 * @return 변환된 String
	 */
	public static String cutLspace(String src) {
		if (src == null)
			return EMPTY_STRING;

		StringBuffer buff = new StringBuffer(src);

		while (buff.toString().startsWith(" ")) {
			try {
				buff = new StringBuffer(buff.toString().substring(1));
			} catch (StringIndexOutOfBoundsException e) {
				return EMPTY_STRING;
			}
		}
		return buff.toString();
	}

	/**
	 * String의 우측 space를 삭제하는 메소드
	 * 
	 * @param src
	 *          String type의 데이터
	 * @return 변환된 String
	 */
	public static String cutRspace(String src) {
		if (src == null)
			return EMPTY_STRING;

		StringBuffer buff = new StringBuffer(src);

		while (buff.toString().endsWith(" ")) {
			try {
				buff = new StringBuffer(buff.toString().substring(0, buff.length() - 1));
			} catch (StringIndexOutOfBoundsException e) {
				return EMPTY_STRING;
			}
		}
		return buff.toString();
	}

	/**
	 * String의 좌우측 space를 삭제하는 메소드
	 * 
	 * @param src
	 *          String type의 데이터
	 * @return 변환된 String
	 */
	public static String cutLRspace(String src) {
		if (src == null)
			return EMPTY_STRING;
		return src.trim();
	}

	/**
	 * 주어진 문자가 ""이거나 NULL인 경우에는 문자열 "NULL"을 반환하는 메소드
	 * 
	 * @param src
	 *          String type의 데이터
	 * 
	 * @return 변환된 String
	 */
	public static String rtnNullChar(String src) {
		if (src == null || src.equals(""))
			return "NULL";
		else
			return src.trim();
	}

	/**
	 * 주어진 문자가 ""이거나 NULL인 경우에는 문자열 "&nbsp"을 리턴하는 메소드
	 * 
	 * @param src
	 *          String type의 데이터
	 * @return 변환된 String
	 */
	public static String rtnNbspChar(String src) {
		if (src != null)
			src = src.trim();

		if ((src == null || src == "") || (src.equalsIgnoreCase("null"))) {
			return "&nbsp";
		} else {
			return src.trim();
		}
	}

	/**
	 * 웹상에서 엔터키를 '<br>
	 * '로 바꾸어주고, 정해진 크기에서 다시 '<br>
	 * '를 삽입해준다.
	 * 
	 * @param cnt
	 *          int type의 카운트
	 * @param src
	 *          String type의 데이터
	 * @return String 변환된 데이터
	 */
	public static String wrappedString(String inputStr, int cnt) {
		String tmpStr = "";
		int i, j;

		inputStr = nvl(inputStr, "");

		for (i = 0, j = 0; i < inputStr.length(); i++, j++) {

			if (inputStr.charAt(i) == '\n') {
				tmpStr = tmpStr.concat("<br>");
				j = -1;
			} else {
				tmpStr = tmpStr.concat(String.valueOf(inputStr.charAt(i)));
			}

			if (j == cnt - 1) {
				tmpStr = tmpStr.concat("<br>");
				j = -1;
			}
		}

		// logger.debug(tmpStr);
		return tmpStr;
	}

	/**
	 * 웹상에서 엔터키를 '<br>
	 * '로 바꾸어 준다.
	 * 
	 * @param src
	 *          String type의 데이터
	 * @return String 변환된 데이터
	 */
	@SuppressWarnings("unused")
	public static String wrappedString(String inputStr) {
		String tmpStr = "";
		int i, j;
		inputStr = nvl(inputStr, "");

		for (i = 0, j = 0; i < inputStr.length(); i++, j++) {

			if (inputStr.charAt(i) == '\n') {
				tmpStr = tmpStr.concat("<br>");
				j = -1;
			} else {
				tmpStr = tmpStr.concat(String.valueOf(inputStr.charAt(i)));
			}
		}

		// logger.debug(tmpStr);
		return tmpStr;
	}

	/**
	 * 웹상에서 엔터키를 ch13로 바꾸어 준다.
	 * 
	 * @param src
	 *          String type의 데이터
	 * @return String 변환된 데이터
	 */
	@SuppressWarnings("unused")
	public static String wrappedStringToCh13(String inputStr) {
		String tmpStr = "";
		int i, j;

		inputStr = nvl(inputStr, "");

		for (i = 0, j = 0; i < inputStr.length(); i++, j++) {

			if (inputStr.charAt(i) == '\n') {
				tmpStr = tmpStr.concat("'/+ch13+'");
				j = -1;
			} else {
				tmpStr = tmpStr.concat(String.valueOf(inputStr.charAt(i)));
			}
		}

		// logger.debug(tmpStr);
		return tmpStr;
	}

	/**
	 * oracle의 nvl(...)과 동일한 기능을 하는 메소드
	 * 
	 * @param src
	 *          String type의 데이터
	 * @param ret
	 *          String type의 리턴되어질 테이터
	 * @return 변환된 String
	 */
	public static String nvl(String src, String ret) {
		if (src == null || src.equals("null") || src.equals(""))
			return ret;
		else
			return src;
	}

	/**
	 * oracle의 nvl(...)과 동일한 기능을 하는 메소드
	 * 
	 * @param src
	 *          String type의 데이터
	 * @param ret
	 *          int type의 리턴되어질 테이터
	 * @return 변환된 int
	 */
	public static int nvl(String src, int ret) {
		if (src == null || src.equalsIgnoreCase("null") || src.equals(""))
			return ret;
		else
			return Integer.parseInt(src);
	}

	/**
	 * src가 null이면 ret를. 아니면 nval을 반환하는 메소드
	 * 
	 * @param src
	 *          String type의 데이터
	 * @param ret
	 *          String 리턴되어질 테이터
	 * @param nval
	 *          String 리턴되어질 테이터
	 * @return int 변환된 데이터
	 */
	public static String nvl(String src, String ret, String nval) {
		if (src == null || src.equalsIgnoreCase("null") || src.equals(""))
			return ret;
		else
			return nval;
	}

	/**
	 * src가 cfm이면 y_str를. 아니면 n_str을 반환하는 메소드
	 * 
	 * @param src
	 *          String type의 데이터
	 * @param cfm
	 *          String type의 조건에 사용될 데이터
	 * @param y_str
	 *          String type의 리턴될 데이터
	 * @param n_str
	 *          String type의 리턴될 데이터
	 * @return 변환된 String
	 */
	public static String nvl(String src, String cfm, String y_str, String n_str) {
		// if ( src.equalsIgnoreCase(cfm) )
		if (src.equals(cfm))
			return y_str;
		else
			return n_str;
	}

	/**
	 * 인자로 받은 String이 null일 경우 EMPTY_STRING을 리턴하는 메소드
	 * 
	 * @param src
	 *          String type의 데이터
	 * @return 변환된 String
	 */
	public static String nvlnull(String src) {
		if (src == null)
			return EMPTY_STRING;
		else if (src.equals("null"))
			return EMPTY_STRING;
		else
			return src;
	}

	/**
	 * src가 null이면 true를. 아니면 false을 반환하는 메소드
	 * 
	 * @param src
	 *          String type의 데이터
	 * @return 변환된 String
	 */
	public static boolean isNull(String src) {
		if (src == null)
			return true;
		else if ((src.trim()).equals(""))
			return true;
		else
			return false;
	}

	/**
	 * len이 될때까지 String의 좌측을 String padStr로 채우는 메소드
	 * 
	 * @param src
	 *          String type의 데이터
	 * @param cnt
	 *          int type의 src와 더해진 문자의 전체개수
	 * @param padStr
	 *          String type의 채워질 데이터
	 * @return 변환된 String
	 */
	public static String leftPadStr(String src, int cnt, String padStr) {
		String tmpValue = "";

		src = src.trim();

		for (int i = 0; i < (cnt - src.length()); i++)
			tmpValue += padStr;

		return tmpValue + src;
	}

	/**
	 * len이 될때까지 String의 우측을 String padStr로 채우는 메소드
	 * 
	 * @param src
	 *          String type의 데이터
	 * @param cnt
	 *          int type의 src와 더해진 문자의 전체개수
	 * @param padStr
	 *          String type의 채워질 데이터
	 * @return 변환된 String
	 */
	public static String rightPadStr(String src, int cnt, String padStr) {
		String tmpValue = "";

		src = src.trim();

		for (int i = 0; i < (cnt - src.length()); i++)
			tmpValue += padStr;

		return src + tmpValue;
	}

	/**
	 * len이 될때까지 String의 우측을 character fill로 채우는 메소드
	 * 
	 * @param src
	 *          String type의 데이터
	 * @param fill
	 *          char type의 채워질 데이터
	 * @param len
	 *          int type의 채워질 개수
	 * @return 변환된 String
	 */
	public static String fillLeftString(String src, char fill, int len) {
		StringBuffer ret;
		// src 가 null 이면 fill로 len만큼 채운후 return
		src = nvl(src, "");
		src = src.trim();

		if (src.equals("")) {
			ret = new StringBuffer(0);

			for (int i = 0; i < len; i++)
				ret.append(fill);
			return ret.toString();
		}

		int src_len = src.length();

		// src의 length가 len보다 크거나 같으면 src를 그대로 return
		if (src_len >= len)
			return src;

		// src의 length가 len보다 작으면 왼쪽을 len만큼 fill로 채운후 return
		ret = new StringBuffer(0);

		for (int i = 0; i < (len - src_len); i++)

			ret.append(fill);
		ret.append(src);

		return ret.toString();
	}

	/**
	 * len이 될때까지 String의 좌측을 character fill로 채우는 메소드
	 * 
	 * @param src
	 *          String type의 데이터
	 * @param fill
	 *          char type의 채워질 데이터
	 * @param len
	 *          int type의 채워질 개수
	 * @return 변환된 String
	 */
	public static String fillRightString(String src, char fill, int len) {
		StringBuffer ret;
		// src 가 null 이면 fill로 len만큼 채운후 return
		src = nvl(src, "");
		src = src.trim();

		if (src.equals("")) {
			ret = new StringBuffer(0);

			for (int i = 0; i < len; i++)
				ret.append(fill);

			return ret.toString();
		}

		int src_len = src.length();

		// src의 length가 len보다 크거나 같으면 src를 그대로 return
		if (src_len >= len)
			return src;

		// src의 length가 len보다 작으면 오른쪽을 len만큼 fill로 채운후 return
		ret = new StringBuffer(0);
		ret.append(src);

		for (int i = 0; i < (len - src_len); i++)
			ret.append(fill);

		return ret.toString();
	}

	/**
	 * len이 될때까지 String의 좌측을 character fill로 채운다.// 나중할 주석 달께...
	 * 
	 * @param src
	 *          String type의 데이터
	 * @param fill
	 *          char type의 채워질 데이터
	 * @param len
	 *          int type의 채워질 개수
	 * @return 변환된 String
	 */
	@SuppressWarnings("unused")
	public static String strToDateForm(String src, String fill) {
		StringBuffer ret;
		// src 가 null 이면 fill로 len만큼 채운후 return
		src = nvl(src, "");
		src = src.trim();

		if (!src.equals("")) {
			src = src.substring(0, 4) + fill + src.substring(4, 6) + fill + src.substring(6);
		}

		return src;
	}

	/**
	 * URL encode 여부확인 메소드
	 * 
	 * @param s
	 *          String type의 데이터
	 * @return encode되었으면 true, 아니면 false
	 */
	public static boolean isURLEncoded(String s) {
		if (s.indexOf('%') == -1)
			return false;

		return true;
	}

	/**
	 * URL Decode 하기위한 메소드
	 * 
	 * @param src
	 *          String type의 데이터
	 * @return 변환된 String
	 */
	public static String URLDecode(String s) {
		ByteArrayOutputStream out = new ByteArrayOutputStream(s.length());

		for (int i = 0; i < s.length(); i++) {
			if (s.charAt(i) == '%') {
				out.write((char) Integer.valueOf(s.substring(i + 1, i + 3), 16).intValue());
				i += 2;
			} else {
				out.write(s.charAt(i));
			}
		}

		return out.toString();
	}

	/**
	 * URL Decode 하기위한 메소드
	 * 
	 * @param src
	 *          String type의 데이터
	 * @return 변환된 String
	 */
	public static String encode(String s) {
		byte byte0 = 10;
		StringBuffer sb = new StringBuffer(s.length());
		ByteArrayOutputStream baos = new ByteArrayOutputStream(byte0);
		OutputStreamWriter writer = new OutputStreamWriter(baos);

		for (int i = 0; i < s.length(); i++) {
			char c = s.charAt(i);
			if (dontNeedEncoding.get(c)) {
				sb.append(Integer.toHexString(c));
				continue;
			}
			try {
				writer.write(c);
				writer.flush();
			} catch (IOException ex) {
				baos.reset();
				continue;
			}

			byte abyte0[] = baos.toByteArray();
			for (int j = 0; j < abyte0.length; j++) {
				char c1 = Character.forDigit(abyte0[j] >> 4 & 0xf, 16);
				if (Character.isLetter(c1))
					c1 -= ' ';
				sb.append(c1);
				c1 = Character.forDigit(abyte0[j] & 0xf, 16);
				if (Character.isLetter(c1))
					c1 -= ' ';
				sb.append(c1);
			}

			baos.reset();
		}
		return sb.toString();
	}

	/**
	 * 디코드하기위한 메소드
	 * 
	 * @param s
	 *          String type의 데이터
	 * @return 변환된 String
	 */
	public static String decode(String src) {
		byte[] abyte = null;
		String str = null;
		try {
			StringBuffer sb = new StringBuffer();
			for (int i = 0; i < src.length(); i += 2)
				sb.append((char) Integer.parseInt(src.substring(i, i + 2), 16));

			str = sb.toString();
			abyte = str.getBytes("8859_1");
		} catch (Exception e) {
			logger.error(e.toString());
		}
		return new String(abyte);
	}

	/**
	 * ["<","&lt;"], [">","&gt;"]를 서로 변환함
	 * 
	 * @param ConvType
	 *          String HTML로 변환하는지, TXT로 변환 하는지 구분
	 * @param content
	 *          String 변환되는 String
	 * @return String
	 */
	public static String HtmlConv(String ConvType, String content) {

		if (content != null) {
			if ("TXT".equals(ConvType)) {
				content = STRConv(content, "&", "&amp;");
				content = STRConv(content, "<", "&lt;");
				content = STRConv(content, ">", "&gt;");
				content = STRConv(content, "\"", "&quot;");
			} else if ("HTML".equals(ConvType)) {
				content = STRConv(content, "&lt;", "<");
				content = STRConv(content, "&gt;", ">");
				content = STRConv(content, "&amp;", "&");
				content = STRConv(content, "&quot;", "\"");
			}
		}
		return content;

	}

	/**
	 * oldString을 newString으로 변환
	 * 
	 * @param line
	 *          String, oldString String, mewString String
	 * @return String
	 */
	public static String STRConv(String line, String oldString, String newString) {

		for (int index = 0; (index = line.indexOf(oldString, index)) >= 0; index += newString.length())
			line = line.substring(0, index) + newString + line.substring(index + oldString.length());

		return line;
	}

	/**
	 * src가 null이거나 null 문자이거나 공백값이면 ret로 변환
	 * 
	 * @param src
	 *          String, ret String
	 * @return String
	 */
	public static String nvl2(String src, String ret) {
		if (src == null || src.equals("null") || src.equals(""))
			return ret;
		else
			return src.trim();
	}

	/**
	 * src가 null이면 공백분자를 반환한다.
	 * 
	 * @param src
	 *          String
	 * @return String
	 */
	public static String trim(String src) {

		if (src != null && src.length() > 0)
			return src.trim();
		else
			return "";
	}

	/**
	 * src가 null이면 ret로 변환
	 * 
	 * @param src
	 *          String, ret String
	 * @return String
	 */
	public static String trim(String src, String ret) {

		if (src != null && src.length() > 0)
			return src.trim();
		else
			return ret;
	}

	public static String getErrorStackTrace(Exception e) {
		StringWriter sw = new StringWriter();
		PrintWriter writer = new PrintWriter(sw);
		e.printStackTrace(writer);

		return sw.toString();
	}

	/**
	 * String 에서 특정 문자열을 원하는 문자열로 변경.
	 * 
	 * <pre>
	 * 예를 들어 "Hello Java World!" 라는 문자열에서 "Java"를 "JSP"로 바꾸려 할 때는
	 * StringUtil.strReplace("Hello Java World!","Java","JSP");
	 * 와 같이 호출하면 "Hello JSP World!"를 반환한다.
	 * </pre>
	 * 
	 * @param dest
	 *          변경 대상이 되는 String
	 * @param src
	 *          찾기를 원하는 String
	 * @param rep
	 *          변경될 문자열
	 * @return 특정 문자열이 원하는 문자열로 변경된 String
	 * @author ykko
	 * @version 1.0
	 * @since 2005.10.21
	 */
	public static String strReplace(String dest, String src, String rep) {

		String retstr = "";
		String left = "";
		int pos = 0;

		if (dest == null)
			return retstr;

		while (true) {
			if ((pos = dest.indexOf(src)) != -1) {
				left = dest.substring(0, pos);
				dest = dest.substring(pos + src.length(), dest.length());
				retstr = retstr + left + rep;
				pos = pos + src.length();
			} else {
				retstr = retstr + dest;
				break;
			}
		}
		return retstr;
	}

	public static String strReplace(String dest, char src, String rep) {

		String retstr = "";
		String left = "";
		int pos = 0;

		if (dest == null)
			return retstr;

		while (true) {
			if ((pos = dest.indexOf(src)) != -1) {
				left = dest.substring(0, pos);
				dest = dest.substring(pos + 1, dest.length());
				retstr = retstr + left + rep;
				pos = pos + 1;
			} else {
				retstr = retstr + dest;
				break;
			}
		}
		return retstr;
	}

	public static String strReplace(String dest, String src, char rep) {

		String retstr = "";
		String left = "";
		int pos = 0;

		if (dest == null)
			return retstr;

		while (true) {
			if ((pos = dest.indexOf(src)) != -1) {
				left = dest.substring(0, pos);
				dest = dest.substring(pos + src.length(), dest.length());
				retstr = retstr + left + rep;
				pos = pos + src.length();
			} else {
				retstr = retstr + dest;
				break;
			}
		}
		return retstr;
	}

	public static String changeSpecialChar1(String str) {

		if (str == null)
			return null;

		String temp = str;

		temp = strReplace(temp, "'", "ㅖ");
		temp = strReplace(temp, "\n\r", " ");
		temp = strReplace(temp, "\n", " ");
		temp = strReplace(temp, '"', "ㅛ");
		temp = strReplace(temp, "\r\n", " ");
		temp = strReplace(temp, "/", "ㅏ");
		temp = strReplace(temp, "-", "ㅓ");

		return temp;
	}

	public static String[] strSplit(String str, String delim) {
		if (str == null || delim == null)
			return null;

		int i = 0;
		String[] arrstr = null;

		StringTokenizer st = new StringTokenizer(str, delim);
		if (st.countTokens() > 0) {
			arrstr = new String[st.countTokens()];
			while (st.hasMoreElements()) {
				arrstr[i] = st.nextToken();
				i++;
			}
		}

		return arrstr;
	}

	// 구분자를 기준으로 스트링 배열 생성(빈스트링 처리 가능)
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public static String[] splits(String pStr, String pDelim) {
		if (pStr == null || pDelim == null) {
			return null;
		}

		ArrayList tokens = new ArrayList();
		int idx = -1; // pDelim을 찾은 위치.
		int lastIndex = 0; // 이전에 pDelim을 찾은 위치.
		idx = pStr.indexOf(pDelim); // 우선 pDelim이 있는지 찾자.

		while (idx >= 0) {
			if (pStr.substring(lastIndex, idx).equals(pDelim))
				idx = idx - pDelim.length();

			tokens.add(pStr.substring(lastIndex, idx));

			if (pStr.substring(lastIndex, idx).equals("")) {
				lastIndex = idx + pDelim.length();
				idx = pStr.indexOf(pDelim, lastIndex);
			} else {
				lastIndex = idx + pDelim.length();
				idx = pStr.indexOf(pDelim, lastIndex + 1);
			}
		}
		tokens.add(pStr.substring(lastIndex));
		return (String[]) tokens.toArray(new String[tokens.size()]);
	}

	// 구분자를 기준으로 스트링 배열 생성(빈스트링 처리 불가능)
	public static String[] splitStr(String pStr, String pDelim) {
		if (pStr == null || pStr.length() == 0 || pDelim == null || pDelim.length() == 0) {
			return null;
		}

		int cnt = 0; // cnt는 반환할 String[]의 length값을 저장하기위한 변수
		String temp = pStr; // temp는 내부적으로 사용하기위해 pStr을 복사한 변수
		String[] rtn = null; // 반환할 String[]

		while (true) {
			int sepIdx = temp.indexOf(pDelim);
			if (sepIdx == -1) {
				cnt++;
				break;
			}
			temp = temp.substring(sepIdx + pDelim.length(), temp.length());
			cnt++;
		}
		rtn = new String[cnt];
		temp = pStr;
		for (int i = cnt; i > 0; i--) {
			int sepIdx = temp.indexOf(pDelim);
			if (sepIdx == -1) {
				rtn[cnt - 1] = temp;
				break;
			}
			rtn[3 - i] = temp.substring(0, sepIdx);
			temp = temp.substring(sepIdx + pDelim.length(), temp.length());
		}
		return rtn;
	}

	// SQL쿼리문에서 ....... IN('str1','str2') .... 형으로 변환
	public static String strQuatLoop(String pStr) {
		int count = 0;
		String strTemp = "";
		String[] arrTemp = splits(pStr, ",");

		for (int i = 0; i < arrTemp.length; i++) {
			if (arrTemp.length == 1) {
				strTemp = "'" + arrTemp[i] + "'";
			} else if (count == 0) {
				strTemp = "'" + arrTemp[i];
			} else if (count == (arrTemp.length - 1)) {
				strTemp += "','" + arrTemp[i] + "'";
			} else {
				strTemp += "','" + arrTemp[i];
			}
			count++;
		}

		return strTemp;

	}

	// 한글 문자열 바이트 단위로 자르는 메소드
	public static String cutString(String str, int len) {

		byte[] by = str.getBytes();
		int count = 0;
		try {
			for (int i = 0; i < len; i++) {
				if ((by[i] & 0x80) == 0x80)
					count++;
			}
			if ((by[len - 1] & 0x80) == 0x80 && (count % 2) == 1)
				len--;
			return new String(by, 0, len);
		} catch (java.lang.ArrayIndexOutOfBoundsException e) {
			// System.out.println(e);
			return str;
		}
	}

	// 16자리 난수 발생
	public static String getEkp_cd(String form_key) {
		return getEkp_cd(form_key, 1);
	}

	public static String getEkp_cd(String form_key, int seed) {
		Random rand = new Random(System.currentTimeMillis() + seed); // seed값을 배정하여
																																	// 생성
		String ekp_cd = Math.abs(rand.nextInt(90) + 10) + Long.toString(System.currentTimeMillis());
		System.out.println("==== EKP_CD = " + ekp_cd);

		return form_key + ekp_cd;
	}

	public static String changeDateFormat(String strDate) {
		String tmpDate = "";

		if (!strDate.equals("") && strDate.length() == 10) {
			tmpDate = strDate.substring(0, 4) + "년 " + strDate.substring(5, 7) + "월 " + strDate.substring(8, 10) + "일";
		}

		return tmpDate;
	}

	// 문자열이 정해진 크기를 넘어서면 정해진 크기만큼 자르고 뒤에 특정문자열을 붙여서 반환 (2009-03-18 김응복)
	public static String limitString(String targetStr, int limit, String addStr) {
		if (targetStr == null) {
			return "";
		} else {
			if (targetStr.length() <= limit) {
				return targetStr;
			} else {
				return targetStr.substring(0, limit) + addStr;
			}
		}
	}

	// 태그를 제거 (2009-05-22 김응복)
	public static String removeTag(String targetStr) {
		String tempStr = "";
		int startIdx = 0;
		int endIdx = 0;

		if (targetStr == null) {
			return "";
		} else {
			tempStr = targetStr;

			while (tempStr.indexOf('<') != -1 && tempStr.indexOf('>') != -1) { // Tag
																																					// 제거
				// System.out.println("================ tempStr : " +tempStr);
				startIdx = tempStr.indexOf('<');
				endIdx = tempStr.indexOf('>');
				tempStr = replace(tempStr, tempStr.substring(startIdx, endIdx + 1), "");
				// System.out.println("========= startIdx : " + startIdx);
				// System.out.println("========= endIdx : " + endIdx);
			}
		}

		return tempStr;
	}

	public static String format2(int value) {
		return format(value, "000");
	}

	public static String getDate(int iDay) {
		Calendar temp = Calendar.getInstance();
		StringBuffer sbDate = new StringBuffer();

		temp.add(Calendar.DAY_OF_MONTH, iDay);
		int nYear = temp.get(Calendar.YEAR);
		int nMonth = temp.get(Calendar.MONTH) + 1;
		int nDay = temp.get(Calendar.DAY_OF_MONTH);

		sbDate.append(nYear);
		if (nMonth < 10)
			sbDate.append("0");
		sbDate.append(nMonth);

		if (nDay < 10)
			sbDate.append("0");
		sbDate.append(nDay);

		return sbDate.toString();
	}
	
	public static String getDateTime() {
		int millisPerHour = 60 * 60 * 1000;
		String DATE_FORMAT = "yyyy-MM-dd HH:mm:ss";
		SimpleDateFormat sdf = new SimpleDateFormat (DATE_FORMAT);
		SimpleTimeZone timeZone = new SimpleTimeZone ( 9 * millisPerHour, "KST" );
		sdf.setTimeZone ( timeZone );
		long time = System.currentTimeMillis();
		Date date = new Date ( time );
		return sdf.format ( date );
	}
	
	public static String encodeURIComponent(String s) {
    String result = null;
    try {
      result = URLEncoder.encode(s, "UTF-8")
      		.replaceAll("\\+", "%20")
          .replaceAll("\\%21", "!")
          .replaceAll("\\%27", "'")
          .replaceAll("\\%28", "(")
          .replaceAll("\\%29", ")")
          .replaceAll("\\%7E", "~");
    } catch (UnsupportedEncodingException e) {
      result = s;
    }
    return result;
  }
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public static void getRequestParamInfo(HttpServletRequest request){
		Map m = request.getParameterMap();
		Set s = m.entrySet();
		Iterator it = s.iterator();
		System.out.println("== Request Parameter Map : START =================================");
		while (it.hasNext()) {
			Map.Entry<String, String[]> entry = (Map.Entry<String, String[]>) it.next();
			String key = entry.getKey();
			String[] value = entry.getValue();
			System.out.println(key + "=" +value[0].toString());
		}
		System.out.println("== Request Parameter Map : END ====================================");
	}
	
	public static void getArrayParams(Map<String , Object> rParam, HttpServletRequest request, Object obj, String[] keyCols) {
		JSONArray jsonArray = new JSONArray();
		JSONParser parser = new JSONParser();
		JSONObject jObj = new JSONObject();
		Method[] m = null;
		String nVal = "";
		String mtNm = "";
		try {
			String paramStr = request.getParameter("param");
			logger.debug("convert string arrayParam :: " + paramStr);
			
			jsonArray = (JSONArray) parser.parse(paramStr);
			List<Object> lvo = new ArrayList<>();
			
			for(int i=0; i<jsonArray.size(); i++) {
				jObj = (JSONObject) jsonArray.get(i);
				obj = obj.getClass().newInstance();
				m = obj.getClass().getDeclaredMethods();
				for(String key : keyCols) {
					if(jObj.get(key) == null) continue;
					else nVal = jObj.get(key).toString();
					
					mtNm = "set".concat(key.substring(0,1).toUpperCase()).concat(key.substring(1));
					
					for(Method mt : m) {
						if(mt.getName().equals(mtNm)) {
							mt.invoke(obj, nVal);
							break;
						}
					}
				}
				lvo.add(obj);
			}
			
			rParam.put("param", lvo);
		}catch (Exception e) {
			e.printStackTrace();
			logger.debug("error");
			logger.error(e.getMessage());
			rParam = null;
		}
	}
	
	
}